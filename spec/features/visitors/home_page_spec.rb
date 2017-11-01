feature 'Home page' do

  scenario 'visit the home page' do
    visit root_path

    expect(page).to have_content I18n.t 'main.title'
  end

  scenario 'visit holder agenda page', :solr do
    manage = create(:manage)
    event = create(:event, position: manage.holder.positions.first)
    Sunspot.commit
    
    expect(event.position.holder.full_name).to eq('First Last')
    visit root_path
    click_link event.position.holder.full_name

    expect(page).to have_content event.position.holder.full_name
  end

  scenario 'visit search by keyword result page', :solr do
    manage = create(:manage)
    event = create(:event, title: 'New event from Capybara', position: manage.holder.positions.first)
    visit root_path

    fill_in :keyword, with: 'Capybara'
    click_button "Buscar"

    expect(page).to have_content event.title
  end

  scenario 'visit search by keyword and area result page', :solr do
    manage = create(:manage)
    event = create(:event, title: 'New event from Capybara', position: manage.holder.positions.first)
    visit root_path

    fill_in :keyword, with: 'Capybara'
    select event.position.area.title, from: :area
    click_button "Buscar"

    expect(page).to have_content event.title
  end

  scenario 'visit non results search page' do
    manage = create(:manage)
    event = create(:event, title: 'New not found event', position: manage.holder.positions.first)
    visit root_path

    fill_in :keyword, with: 'Capybara'
    click_button I18n.t('main.form.search')

    expect(page).not_to have_content event.title
  end

end

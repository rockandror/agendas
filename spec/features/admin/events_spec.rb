feature 'Events' do

  let(:user)  { create :user }
  before      { signin user.email, user.password }

  scenario 'visit the events index page' do
    visit events_path

    expect(page).to have_content I18n.t 'backend.events'
  end

  scenario 'visit create event form' do
    create :manage, user: user
    visit new_event_path

    expect(page).to have_selector('#new_event')
    expect(page).not_to have_selector('#edit_event')
  end

  scenario 'visit show event page' do
    manage = create :manage, user: user
    event = create(:event, user: user, position: manage.holder.positions.first)
    visit events_path

    click_link event.title

    expect(page).to have_content event.title
  end

  scenario 'should be able to edit and update title' do
    manage = create :manage, user: user
    event = create(:event, user: user, position: manage.holder.positions.first)

    visit edit_event_path(event)
    fill_in :event_title, with: 'New event title'
    click_button "Guardar"

    expect(page).to have_content 'New event title'
  end

  scenario 'visit search by keyword and area result page', :solr do
    manage = create :manage, user: user
    event = create(:event, title: 'New event from Capybara', position: manage.holder.positions.first)

    visit root_path
    fill_in :keyword, with: 'Capybara'
    select event.position.area.title, from: :area
    click_button I18n.t('main.form.search')

    expect(page).to have_content event.title
  end

  scenario 'visit non results search page' do
    manage = create :manage, user: user
    event = create(:event, title: 'New not found event', position: manage.holder.positions.first)
    visit root_path

    fill_in :keyword, with: 'Capybara'
    click_button I18n.t('main.form.search')

    expect(page).not_to have_content event.title
  end

end

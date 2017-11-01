feature 'Event page' do

  scenario 'visit the event detail page' do
    manage = create(:manage)
    event = create(:event, position: manage.holder.positions.first)
    visit root_path

    click_link event.title

    expect(page).to have_content event.title
  end

end

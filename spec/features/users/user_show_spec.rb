feature 'User profile page', :devise do

  scenario 'user cannot see own profile' do
    user = create(:user)
    login_as(user, :scope => :user)

    visit user_path(user)

    expect(page).to have_content I18n.t 'backend.access_denied'
  end

  scenario "user cannot see another user's profile" do
    me = create(:user)
    other = create(:user, email: 'other@example.com')
    login_as(me, :scope => :user)
    Capybara.current_session.driver.header 'Referer', root_path

    visit user_path(other)

    expect(page).to have_content I18n.t 'backend.access_denied'
  end

end

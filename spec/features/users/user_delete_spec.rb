include Warden::Test::Helpers
Warden.test_mode!

feature 'User delete', :devise, :js do

  after(:each) do
    Warden.test_reset!
  end

  scenario 'user can not delete own account' do
    user = create(:user, :admin)
    login_as(user, :scope => :user)

    visit users_path

    expect(page).to have_content I18n.t 'backend.users'
    page.click_link('', href: user_path(user))
    expect(page).to have_content 'No ha sido posible realizar la operación'
  end

end
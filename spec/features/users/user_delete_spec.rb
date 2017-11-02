feature 'User delete', :devise, :js do

  scenario 'user can not delete own account', :js do
    user = create(:user, :admin)
    login_as(user, :scope => :user)

    visit users_path

    expect(page).to have_content I18n.t 'backend.users'
    save_screenshot
    click_link('', href: user_path(user))
    expect(page).to have_content 'No ha sido posible realizar la operación'
  end

end
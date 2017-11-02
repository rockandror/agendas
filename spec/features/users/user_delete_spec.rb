feature 'User delete', :devise, :js do

  scenario 'user can not delete own account' do
    user = create(:user, :admin)
    login_as(user, :scope => :user)

    visit users_path

    within "#user_#{user.id}" do
      find('a.delete').trigger('click')
    end
    expect(page).to have_content 'No ha sido posible realizar la operación'
  end

end
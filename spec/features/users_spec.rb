feature "Users" do

  describe "index" do

    scenario "user sees own email address" do
      user = create(:user, :admin)
      login_as(user, scope: :user)

      visit users_path

      expect(page).to have_content user.email
    end

  end

  feature "show" do

    scenario "user cannot see own profile" do
      user = create(:user)
      login_as(user, :scope => :user)

      visit user_path(user)

      expect(page).to have_content I18n.t "backend.access_denied"
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

  describe "edit" do

    scenario "admin can change own email address" do
      user = create(:user, :admin)
      login_as(user, :scope => :user)
      visit edit_user_path(user)

      fill_in :user_email, :with => "adminemail@example.com"
      click_button I18n.t "backend.save"

      expect(page).to have_content I18n.t "backend.successfully_updated_record"
    end

    scenario "admin can change other user email address" do
      admin = create(:user, :admin, email: "adminemail@example.com")
      login_as(admin, :scope => :user)
      user = create(:user)
      visit edit_user_path(user)

      fill_in :user_email, :with => "useremail@example.com"
      click_button I18n.t "backend.save"

      expect(page).to have_content I18n.t "backend.successfully_updated_record"
    end

    scenario "user cannot edit another user profile", :me do
      me = create(:user)
      other = create(:user, email: "other@example.com")
      login_as(me, :scope => :user)

      visit edit_user_path(other)

      expect(page).to have_content I18n.t "backend.access_denied"
    end

  end

  describe "destroy" do

    scenario "user can not delete own account" do
      user = create(:user, :admin)
      login_as(user, :scope => :user)

      visit users_path

      within "#user_#{user.id}" do
        find("a.delete").click
      end
      expect(page).to have_content "No ha sido posible realizar la operación"
    end

  end

end
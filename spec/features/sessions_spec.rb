require 'rails_helper'

feature "Sessions" do
  feature "sessions test" do
    given!(:admin_user) { create(:user) }
    scenario "login and logout" do
      visit root_path
      # ログイン画面に遷移すること
      expect(page).to have_current_path(new_user_session_path)
      # 登録されていないユーザーではログインができないこと
      login("notest@email.com", "password")
      expect(page).to have_current_path(new_user_session_path)
      # 誤ったパスワードではログインができないこと
      login(admin_user.email, "password1")
      expect(page).to have_current_path(new_user_session_path)
      # 正しいユーザー情報ではログインが成功すること
      login(admin_user.email, admin_user.password)
      expect(page).to have_current_path(root_path)
      # ログアウトが成功すること
      click_link "Logout"
      expect(page).to have_current_path(new_user_session_path)
    end
  end
end

require 'rails_helper'

feature "Sessions" do
  feature "sessions test" do
    given!(:admin_user) { create(:user) }
    scenario "login and logout" do
      visit root_path
      # ログイン画面に遷移すること
      expect(page).to have_current_path(new_user_session_path)
      # 登録されていないユーザーではログインができないこと
      first("input[type='email']").set("notest@email.com")
      first("input[type='password']").set("password")
      click_button "Log in"
      expect(page).to have_current_path(new_user_session_path)
      # 誤ったパスワードではログインができないこと
      first("input[type='email']").set(admin_user.email)
      first("input[type='password']").set("password1")
      click_button "Log in"
      expect(page).to have_current_path(new_user_session_path)
      # 正しいユーザー情報ではログインが成功すること
      first("input[type='email']").set(admin_user.email)
      first("input[type='password']").set(admin_user.password)
      click_button "Log in"
      expect(page).to have_current_path(root_path)
      # ログアウトが成功すること
      click_link "Logout"
      expect(page).to have_current_path(new_user_session_path)
    end
  end
end

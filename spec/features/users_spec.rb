require 'rails_helper'

feature "Users" do
  feature "user registration test" do
    given!(:admin_user) { create(:user) }
    scenario "sign up test" do
      visit root_path
      # ログイン画面に遷移すること
      expect(page).to have_current_path(new_user_session_path)
      # "sign up"ボタンを押下するとユーザー登録画面に遷移すること
      click_link "Sign up"
      expect(page).to have_current_path(new_user_registration_path)
      # ユーザーネームが空欄のとき登録が失敗すること
      sign_up("", "test2@email.com", "password", "password")
      expect(page).to have_selector ".form p", text: "ユーザーネーム が入力されていません。"
      # ユーザーネームが20文字以上のとき登録が失敗すること
      sign_up("abcdefghijklmnopqrstuvwxyg", "test2@email.com", "password", "password")
      expect(page).to have_selector ".form p", text: "ユーザーネーム は20文字以下に設定して下さい。"
      # emailが空欄のとき登録が失敗すること
      sign_up("TestUser", "", "password", "password")
      expect(page).to have_selector ".form p", text: "メールアドレス が入力されていません。"
      # パスワードが空欄のとき登録が失敗すること
      sign_up("TestUser", "test2@email.com", "", "")
      expect(page).to have_selector ".form p", text: "パスワード が入力されていません。"
      # パスワードと確認パスワードが一致しないとき登録が失敗すること
      sign_up("TestUser", "test2@email.com", "password", "password1")
      expect(page).to have_selector ".form p", text: "確認パスワード が内容とあっていません。"
      # すでに登録されているemailのとき登録が失敗すること
      sign_up("TestUser", "test@email.com", "password", "password")
      expect(page).to have_selector ".form p", text: "メールアドレス は既に使用されています。"
      # 正しい入力値のとき登録が成功してroot_pathに遷移すること
      sign_up("TestUser", "test2@email.com", "password", "password")
      expect(page).to have_current_path(root_path)
    end

    scenario "user destroy test" do
      visit root_path
      # ログイン画面に遷移すること
      expect(page).to have_current_path(new_user_session_path)
      # ログイン
      sign_in(admin_user.email, admin_user.password)
      expect(page).to have_current_path(root_path)
      # ユーザー情報編集ページへ遷移できること
      click_link "Setting"
      expect(page).to have_current_path(edit_user_path(admin_user))
      # アカウント削除ボタンを押下するとDBからユーザー情報が削除されsign_inページへ遷移すること
      expect { click_link "アカウントを削除" }.to change(User, :count).by(-1)
      expect(page).to have_current_path(new_user_session_path)
    end
  end
end

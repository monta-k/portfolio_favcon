require 'rails_helper'

feature "Users" do
  feature "user registration test" do
    given!(:admin_user) { create(:user) }
    # ユーザー登録をテスト
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
      # ユーザーネームが21文字以上のとき登録が失敗すること
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

    # ユーザーの削除をテスト
    scenario "user destroy test" do
      visit root_path
      # ログイン画面に遷移すること
      expect(page).to have_current_path(new_user_session_path)
      # ログイン
      sign_in_fill(admin_user.email, admin_user.password)
      expect(page).to have_current_path(root_path)
      # ユーザー情報編集ページへ遷移できること
      click_link "Setting"
      expect(page).to have_current_path(edit_user_path(admin_user))
      # アカウント削除ボタンを押下するとDBからユーザー情報が削除されsign_in_fillページへ遷移すること
      expect { click_link "アカウントを削除" }.to change(User, :count).by(-1)
      expect(page).to have_current_path(new_user_session_path)
    end
  end

  feature "user information edit test" do
    given!(:admin_user) { create(:user) }
    # ユーザーの基本情報の編集をテスト
    scenario "user edit test" do
      visit root_path
      # ログイン画面に遷移すること
      expect(page).to have_current_path(new_user_session_path)
      # ログイン
      sign_in_fill(admin_user.email, admin_user.password)
      expect(page).to have_current_path(root_path)
      # ユーザー情報編集ページへ遷移できること
      click_link "Setting"
      expect(page).to have_current_path(edit_user_path(admin_user))
      # ユーザーネームが空欄のとき編集に失敗すること
      user_information_edit("", "test2@email.com")
      expect(page).to have_selector ".profile-form-wrap", text: "ユーザーネーム が入力されていません。"
      # ユーザーネームが21文字以上のとき編集に失敗すること
      user_information_edit("abcdefghijklmnopqrstuvwxyg", "test2@email.com")
      expect(page).to have_selector ".profile-form-wrap", text: "ユーザーネーム は20文字以下に設定して下さい。"
      # emailが空欄のとき編集に失敗すること
      user_information_edit("TestUser2", "")
      expect(page).to have_selector ".profile-form-wrap", text: "メールアドレス が入力されていません。"
      # 正しい入力値のとき編集が成功してroot_pathに遷移すること
      user_information_edit("TestUser2", "test2@email.com")
      expect(page).to have_current_path(root_path)
    end

    # パスワード変更をテスト
    scenario "password change test" do
      visit root_path
      # ログイン画面に遷移すること
      expect(page).to have_current_path(new_user_session_path)
      # ログイン
      sign_in_fill(admin_user.email, admin_user.password)
      expect(page).to have_current_path(root_path)
      # ユーザー情報編集ページへ遷移できること
      click_link "Setting"
      expect(page).to have_current_path(edit_user_path(admin_user))
      # パスワード編集画面へ遷移できること
      click_link "パスワード変更"
      expect(page).to have_current_path(edit_user_registration_path(admin_user))
      # 現在のパスワードが空欄のとき編集に失敗すること
      password_edit("", "password1", "password1")
      expect(page).to have_selector ".edit_user p", text: "現在のパスワード が入力されていません。"
      # 現在のパスワードが誤っているとき編集に失敗すること
      password_edit("password2", "password1", "password1")
      expect(page).to have_selector ".edit_user p", text: "現在のパスワード は有効でありません。"
      # 新しいパスワードと新しいパスワードの確認が一致しないとき編集が失敗すること
      password_edit("password", "password1", "password2")
      expect(page).to have_selector ".edit_user p", text: "確認パスワード が内容とあっていません。"
      # 新しいパスワードが5文字以下のとき編集が失敗すること
      password_edit("password", "pass", "pass")
      expect(page).to have_selector ".edit_user p", text: "パスワード は6文字以上に設定して下さい。"
      # 正しい入力値のとき編集が成功してroot_pathに遷移すること
      password_edit("password", "password2", "password2")
      expect(page).to have_current_path(root_path)
    end
  end
end

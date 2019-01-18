require "rails_helper"

feature "Relationship" do
  feature "follow and unfollow test" do
    # フォローするユーザー
    given!(:following_user) { create(:user, username: "TestUser1", email: "test1@email.com") }
    # フォローされるユーザー
    given!(:no_follower_user) { create(:user, username: "TestUser3", email: "test3@email.com") }

    scenario "follow and unfollow test" do
      visit root_path
      # ログイン画面に遷移すること
      expect(page).to have_current_path(new_user_session_path)
      # 正しいユーザー情報ではログインが成功すること
      login(following_user.email, following_user.password)
      expect(page).to have_current_path(root_path)
      # フォローしていないユーザーのページに遷移
      visit user_path(no_follower_user)
      expect(page).to have_current_path(user_path(no_follower_user))
      # フォローボタンが表示されていること
      expect(page).to have_button "フォローする"
      # フォロワーが0であること
      expect(page).to have_selector "#followers", text: 0
      # フォローするボタンを押下するとRelationshipレコードが作成されること
      expect { click_button "フォローする" }.to change(Relationship, :count).by(1)
      # フォロー解除ボタンが表示されること
      expect(page).to have_button "フォロー解除する"
      # フォロワーが1になること
      expect(page).to have_selector "#followers", text: 1
      # フォロー解除ボタンを押下するとRelationshipレコードが削除されること
      expect { click_button "フォロー解除する" }.to change(Relationship, :count).by(-1)
      # フォローボタンが表示されていること
      expect(page).to have_button "フォローする"
      # フォロワーが0になること
      expect(page).to have_selector "#followers", text: 0
    end
  end
end

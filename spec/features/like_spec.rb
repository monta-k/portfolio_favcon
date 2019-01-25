require "rails_helper"

feature "Likes" do
  feature "like test" do
    # フォローしているユーザー
    given!(:following_user) { create(:user, username: "TestUser1", email: "test1@email.com") }
    # フォローされているユーザー
    given!(:follower_user) { create(:user, username: "TestUser2", email: "test2@email.com") }
    given!(:relationship) { create(:relationship, follower_id: following_user.id, followed_id: follower_user.id) }
    # フォローしているユーザーの投稿
    given!(:following_user_post) { create(:movie_post, content: "自分の感想", user_id: following_user.id) }
    # フォローされているユーザーの投稿
    given!(:follower_user_post) { create(:music_post, content: "フォローしているユーザーの感想", user_id: follower_user.id) }
    scenario "like and unlike test" do
      visit root_path
      # ログイン画面に遷移すること
      expect(page).to have_current_path(new_user_session_path)
      # 正しいユーザー情報ではログインが成功すること
      login(following_user.email, following_user.password)
      expect(page).to have_current_path(root_path)
      # 自分の投稿とフォローしているユーザーの投稿が表示されること
      expect(page).to have_selector ".post-user-info h6", text: following_user.username
      expect(page).to have_selector ".content p", text: following_user_post.content
      expect(page).to have_selector ".post-user-info h6", text: follower_user.username
      expect(page).to have_selector ".content p", text: follower_user_post.content
      # いいねボタンが表示されていること
      expect(page).to have_css "#post-like-#{follower_user_post.id} .love"
      # いいね数が0であること
      expect(page).to have_selector "#post-like-#{follower_user_post.id} p", text: "0件"
      # いいねボタンを押下するとLikeレコードが作成されること
      expect { find("#post-like-#{follower_user_post.id} .love").click }.to change(Like, :count).by(1)
      # いいね解除ボタンが表示されていること
      expect(page).to have_css "#post-like-#{follower_user_post.id} .no-love"
      # いいね数が1であること
      expect(page).to have_selector "#post-like-#{follower_user_post.id} p", text: "1件"
      # いいね解除ボタンを押下するとLikeレコードが削除されること
      expect { find("#post-like-#{follower_user_post.id} .no-love").click }.to change(Like, :count).by(-1)
      # いいねボタンが表示されていること
      expect(page).to have_css "#post-like-#{follower_user_post.id} .love"
      # いいね数が0であること
      expect(page).to have_selector "#post-like-#{follower_user_post.id} p", text: "0件"
    end
  end
end

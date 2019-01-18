require "rails_helper"

feature "Pages" do
  feature "timeline test" do
    # フォローしているユーザー
    given!(:following_user) { create(:user, username: "TestUser1", email: "test1@email.com") }
    # フォローされているユーザー
    given!(:follower_user) { create(:user, username: "TestUser2", email: "test2@email.com") }
    # フォローされていないユーザー
    given!(:no_follower_user) { create(:user, username: "TestUser3", email: "test3@email.com") }
    given!(:relationship) { create(:relationship, follower_id: following_user.id, followed_id: follower_user.id) }
    # フォローしているユーザーの投稿
    given!(:following_user_post) { create(:movie_post, content: "自分の感想", user_id: following_user.id) }
    # フォローされているユーザーの投稿
    given!(:follower_user_post) { create(:music_post, content: "フォローしているユーザーの感想", user_id: follower_user.id) }
    # フォローされていないユーザーの投稿
    given!(:no_follower_user_post) { create(:music_post, content: "フォローしていないユーザーの感想", user_id: no_follower_user.id) }

    scenario "timeline test" do
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
      # フォローしていないユーザの投稿が表示されないこと
      expect(page).not_to have_selector ".post-user-info h6", text: no_follower_user.username
      expect(page).not_to have_selector ".content p", text: no_follower_user_post.content
    end
  end
end

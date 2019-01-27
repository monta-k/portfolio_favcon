require 'rails_helper'

feature "Comments" do
  feature "Comments test" do
    # コメントするユーザー
    given!(:comment_user) { create(:user, username: "TestUser1", email: "test1@email.com") }
    # コメントされているユーザー
    given!(:commented_user) { create(:user, username: "TestUser2", email: "test2@email.com") }
    given!(:relationship) { create(:relationship, follower_id: comment_user.id, followed_id: commented_user.id) }
    # コメントされる投稿
    given!(:commented_user_post) { create(:movie_post, user_id: commented_user.id) }
    # コメント
    given!(:comment) { create(:comment, user_id: commented_user.id, post_id: commented_user_post.id, comment: "コメント") }
    scenario "comment index and create and destroy test" do
      visit root_path
      # ログイン
      login(comment_user.email, comment_user.password)
      # 投稿にコメント件数とコメント一覧へのリンクがあること
      expect(page).to have_selector "#post-comment-#{commented_user_post.id} p", text: 1
      expect(page).to have_link "コメント一覧"
      # コメントリンクを押下するとコメント一覧ページに遷移すること
      click_link "コメント一覧"
      expect(page).to have_current_path(post_comments_path(commented_user_post))
      # コメント件数が1件であること
      expect(page).to have_selector ".comment-list h3", text: "1件"
      # コメントが表示されていること
      expect(page).to have_selector "#comment-#{comment.id} .comment p", text: comment.comment
      expect(page).to have_selector "#comment-#{comment.id} .comment-user-info", text: commented_user.username
      # コメントを投稿するとコメントが作成され、コメント一覧ページが表示されること
      fill_in "コメントを投稿する", with: "コメントテスト"
      expect { click_button "投稿する" }.to change(Comment, :count).by(1)
      expect(page).to have_current_path(post_comments_path(commented_user_post))
      # コメント数が1件増えていること
      expect(page).to have_selector ".comment-list h3", text: "2件"
      # 投稿したコメントが表示されていること
      expect(page).to have_selector "#comment-#{comment.id + 1} .comment p", text: "コメントテスト"
      expect(page).to have_selector "#comment-#{comment.id + 1} .comment-user-info", text: comment_user.username
      # 自分で投稿したコメントにはコメント削除ボタンが表示されていること
      expect(page).to have_selector "#comment-#{comment.id + 1}", text: "コメント削除"
      # 他ユーザーが投稿したコメントにはコメント削除ボタンが表示されないこと
      expect(page).not_to have_selector "#comment-#{comment.id}", text: "コメント削除"
      # コメント削除ボタンを押下するとコメントが削除され、コメント一覧ページが表示されること
      expect { click_link "コメント削除" }.to change(Comment, :count).by(-1)
      expect(page).to have_current_path(post_comments_path(commented_user_post))
      # コメント件数が1件減っていること
      expect(page).to have_selector ".comment-list h3", text: "1件"
      # 削除したコメントが表示されていないこと
      expect(page).not_to have_selector "#comment-#{comment.id + 1}"
    end
  end
end

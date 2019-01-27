require 'rails_helper'

describe CommentsController do
  describe "GET #index" do
    # コメントするユーザー
    let(:comment_user) { create(:user, username: "TestUser1", email: "test1@email.com") }
    # コメントされるユーザー
    let(:commented_user) { create(:user, username: "TestUser2", email: "test2@email.com") }
    # コメントされる投稿
    let(:commented_user_post) { create(:movie_post, user_id: commented_user.id) }

    before do
      sign_in comment_user
      get :index, params: { post_id: commented_user_post.id }
    end

    # @postに要求された投稿が割り当てられていること
    it "assigns correct post to @post" do
      expect(assigns(:post)).to eq commented_user_post
    end
  end

  describe "POST #create" do
    # コメントするユーザー
    let(:comment_user) { create(:user, username: "TestUser1", email: "test1@email.com") }
    # コメントされるユーザー
    let(:commented_user) { create(:user, username: "TestUser2", email: "test2@email.com") }
    # コメントされる投稿
    let(:commented_user_post) { create(:movie_post, user_id: commented_user.id) }

    before do
      sign_in comment_user
    end

    # Commentモデルが作成されること
    it "save the new comment in the datebase" do
      expect { post :create, xhr: true, params: { post_id: commented_user_post.id, comment: { post_id: commented_user_post.id, comment: "コメント" } } }.to change(Comment, :count).by(1)
    end

    # @postにコメントをつけた投稿が含まれていると
    it "assigns commented user post to @post" do
      post :create, xhr: true, params: { post_id: commented_user_post.id, comment: { post_id: commented_user_post.id, comment: "コメント" } }
      expect(assigns(:post)).to eq commented_user_post
    end

    # HTTPリクエストが成功すること
    it "responds 200 suceess" do
      post :create, xhr: true, params: { post_id: commented_user_post.id, comment: { post_id: commented_user_post.id, comment: "コメント" } }
      expect(response.status).to eq 200
    end
  end

  describe "DELETE #destory" do
    # コメントしているユーザー
    let(:comment_user) { create(:user, username: "TestUser1", email: "test1@email.com") }
    # コメントされているユーザー
    let(:commented_user) { create(:user, username: "TestUser2", email: "test2@email.com") }
    # コメントされている投稿
    let(:commented_user_post) { create(:movie_post, user_id: commented_user.id) }
    # コメント
    let!(:comment) { create(:comment, user_id: comment_user.id, post_id: commented_user_post.id, comment: "コメント") }

    before do
      sign_in comment_user
    end

    # Commentモデルが削除されること
    it "delete comment from the datebase" do
      expect { post :destroy, xhr: true, params: { id: comment.id } }.to change(Comment, :count).by(-1)
    end

    # @postにコメントがついていた投稿が含まれていること
    it "assigns commented user post to @post" do
      post :destroy, xhr: true, params: { id: comment.id }
      expect(assigns(:post)).to eq commented_user_post
    end

    it "responds 200 suceess" do
      post :destroy, xhr: true, params: { id: comment.id }
      expect(response.status).to eq 200
    end
  end
end

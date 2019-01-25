require 'rails_helper'

describe LikesController do
  describe "POST #create" do
    # いいねするユーザー
    let(:like_user) { create(:user, username: "TestUser1", email: "test1@email.com") }
    # いいねされるユーザー
    let(:liked_user) { create(:user, username: "TestUser2", email: "test2@email.com") }
    # いいねされる投稿
    let(:liked_user_post) { create(:movie_post, user_id: liked_user.id) }

    before do
      sign_in like_user
    end

    # likeモデルが作成されること
    it "saves the new like in the database" do
      expect { post :create, xhr: true, params: { post_id: liked_user_post.id } }.to change(Like, :count).by(1)
    end

    # HTTPリクエストが成功すること
    it "responds 200 suceess" do
      post :create, xhr: true, params: { post_id: liked_user_post.id }
      expect(response.status).to eq 200
    end
  end

  describe "DELETE #destroy" do
    # いいねしているユーザー
    let(:like_user) { create(:user, username: "TestUser1", email: "test1@email.com") }
    # いいねされるユーザー
    let(:liked_user) { create(:user, username: "TestUser2", email: "test2@email.com") }
    # いいねされている投稿
    let(:liked_user_post) { create(:movie_post, user_id: liked_user.id) }
    # いいね
    let!(:like) { create(:like, user_id: like_user.id, post_id: liked_user_post.id) }

    before do
      sign_in like_user
    end

    # likeモデルが削除されること
    it "saves the new like in the database" do
      expect { post :destroy, xhr: true, params: { id: like.id } }.to change(Like, :count).by(-1)
    end

    # HTTPリクエストが成功すること
    it "responds 200 suceess" do
      post :destroy, xhr: true, params: { id: like.id }
      expect(response.status).to eq 200
    end
  end
end

require "rails_helper"

describe PagesController do
  describe "GET #index" do
    # フォローしているユーザー
    let(:following_user) { create(:user, username: "TestUser1", email: "test1@email.com") }
    # フォローされているユーザー
    let(:follower_user) { create(:user, username: "TestUser2", email: "test2@email.com") }
    # フォローされていないユーザー
    let(:no_follower_user) { create(:user, username: "TestUser3", email: "test3@email.com") }
    let!(:relationship) { create(:relationship, follower_id: following_user.id, followed_id: follower_user.id) }
    # フォローしているユーザーの投稿
    let(:following_user_post) { create(:movie_post, user_id: following_user.id) }
    # フォローされているユーザーの投稿
    let(:follower_user_post) { create(:music_post, user_id: follower_user.id) }
    # フォローされていないユーザーの投稿
    let(:no_follower_user_post) { create(:music_post, user_id: no_follower_user.id) }

    before do
      sign_in following_user
      get :index
    end

    # @postsに自分の投稿が含まれていること
    it "assigns my post to @posts" do
      expect(assigns(:posts)).to include following_user_post
    end

    # @postsにフォローしているユーザの投稿が含まれていること
    it "assigns follower user's post to @posts" do
      expect(assigns(:posts)).to include follower_user_post
    end

    # @postsにフォローしていないユーザーの投稿が含まれていないこと
    it "not assigns no follower user's post to @posts" do
      expect(assigns(:posts)).not_to include no_follower_user_post
    end

    # :indexテンプレートが表示されること
    it "renders the show_follow template" do
      expect(response).to render_template :index
    end

    # HTTPリクエストが成功すること
    it "responds 200 suceess" do
      expect(response.status).to eq 200
    end
  end
end

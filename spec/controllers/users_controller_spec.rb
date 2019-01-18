require 'rails_helper'

describe UsersController do
  describe 'GET #following' do
    # フォローしているユーザー
    let(:following_user) { create(:user, username: "TestUser1", email: "test1@email.com") }
    # フォローされているユーザー
    let(:follower_user) { create(:user, username: "TestUser2", email: "test2@email.com") }
    # フォローされていないユーザー
    let(:no_follower_user) { create(:user, username: "TestUser3", email: "test3@email.com") }
    let!(:relationship) { create(:relationship, follower_id: following_user.id, followed_id: follower_user.id) }

    before do
      sign_in following_user
      get :following, params: { id: following_user.id }
    end

    # @titleに"フォローしているユーザー"が割り当てられていること
    it "assigns correct title to @title" do
      expect(assigns(:title)).to eq "フォローしているユーザー"
    end

    # @userにフォローするユーザーが割り当てられていること
    it "assigns following user to @user" do
      expect(assigns(:user)).to eq following_user
    end

    # @usersにフォローされているユーザーが割り当てられていること
    it "assigns follower user to @users" do
      expect(assigns(:users)).to include follower_user
    end

    # @usersにフォローされていないユーザーが割り当てらていないこと
    it "not assigns not follower user to @users" do
      expect(assigns(:users)).not_to include no_follower_user
    end

    # "show_follow"テンプレートが表示されること
    it "renders the show_follow template" do
      expect(response).to render_template :show_follow
    end

    # HTTPリクエストが成功すること
    it "responds 200 suceess" do
      expect(response.status).to eq 200
    end
  end

  describe 'GET #followers' do
    # フォローしているユーザー
    let(:following_user) { create(:user, username: "TestUser1", email: "test1@email.com") }
    # フォローされているユーザー
    let(:follower_user) { create(:user, username: "TestUser2", email: "test2@email.com") }
    # フォローされていないユーザー
    let(:no_follower_user) { create(:user, username: "TestUser3", email: "test3@email.com") }
    let!(:relationship) { create(:relationship, follower_id: following_user.id, followed_id: follower_user.id) }

    before do
      sign_in following_user
      get :followers, params: { id: follower_user.id }
    end

    # @titleに"フォローしているユーザー"が割り当てられていること
    it "assigns correct title to @title" do
      expect(assigns(:title)).to eq "フォローされているユーザー"
    end

    # @userにフォローされているユーザーが割り当てられていること
    it "assigns following user to @user" do
      expect(assigns(:user)).to eq follower_user
    end

    # @usersにフォローしているユーザーが割り当てられていること
    it "assigns follower user to @users" do
      expect(assigns(:users)).to include following_user
    end

    # @usersにフォローしているユーザーが割り当てらていないこと
    it "not assigns not follower user to @users" do
      expect(assigns(:users)).not_to include no_follower_user
    end

    # "show_follow"テンプレートが表示されること
    it "renders the show_follow template" do
      expect(response).to render_template :show_follow
    end

    # HTTPリクエストが成功すること
    it "responds 200 suceess" do
      expect(response.status).to eq 200
    end
  end
end

require 'rails_helper'

describe RelationshipsController do
  describe "POST #create" do
    # フォローするユーザー
    let(:following_user) { create(:user, username: "TestUser1", email: "test1@email.com") }
    # フォローされるユーザー
    let(:follower_user) { create(:user, username: "TestUser2", email: "test2@email.com") }

    before do
      sign_in following_user
      post :create, params: { followed_id: follower_user.id }
    end

    # @userにフォローされるユーザーが割り当てられていること
    it "assigns follower user to @user" do
      expect(assigns(:user)).to eq follower_user
    end
  end

  describe "DELETE #destroy" do
    # フォローしているユーザー
    let(:following_user) { create(:user, username: "TestUser1", email: "test1@email.com") }
    # フォローされているユーザー
    let(:follower_user) { create(:user, username: "TestUser2", email: "test2@email.com") }
    let!(:relationship) { create(:relationship, follower_id: following_user.id, followed_id: follower_user.id) }

    before do
      sign_in following_user
      post :destroy, params: { id: relationship.id }
    end

    # @userにフォロー解除されるユーザーが割り当てられていること
    it "assigns follower user to @user" do
      expect(assigns(:user)).to eq follower_user
    end
  end
end

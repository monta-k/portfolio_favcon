class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  after_action :create_notifications, only: [:create]

  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  private

  def create_notifications
    Notification.create(user_id: @user.id, notified_by_id: current_user.id, post_id: nil, notified_type: "フォロー")
  end
end

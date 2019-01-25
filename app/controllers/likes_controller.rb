class LikesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  after_action :create_notifications, only: [:create]

  def create
    @like = current_user.likes.build(like_params)
    @post = @like.post
    if @like.save
      respond_to :js
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @post = @like.post
    if @like.destroy
      respond_to :js
    end
  end

  private

  def like_params
    params.permit(:post_id)
  end

  def create_notifications
    return if @post.user.id == current_user.id
    Notification.create(user_id: @post.user_id, notified_by_id: current_user.id, post_id: @post.id, notified_type: "いいね")
  end
end

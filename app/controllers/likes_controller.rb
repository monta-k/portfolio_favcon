class LikesController < ApplicationController
  POSTS_PER_PAGE = 6
  before_action :authenticate_user!, only: [:create, :destroy, :index]
  after_action :create_notifications, only: [:create]

  def create
    @like = current_user.likes.build(like_params)
    @post = @like.post
    if @like.save
      respond_to do |format|
        format.html { redirect_to request.referrer }
        format.js
      end
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @post = @like.post
    if @like.destroy
      respond_to do |format|
        format.html { redirect_to request.referrer }
        format.js
      end
    end
  end

  def index
    @user = User.find(params[:user_id])
    @posts = Post.joins(likes: :user).includes(likes: :user).where(likes: { user_id: @user.id }).order("likes.created_at DESC").page(params[:page]).per(POSTS_PER_PAGE)
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

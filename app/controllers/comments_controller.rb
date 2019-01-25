class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  after_action :create_notifications, only: [:create]

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      @post = @comment.post
      respond_to :js
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      @post = @comment.post
      respond_to :js
    end
  end

  def index
    @post = Post.includes(:comments).find(params[:post_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:post_id, :comment)
  end

  def create_notifications
    return if @post.user.id == current_user.id
    Notification.create(user_id: @post.user_id, notified_by_id: current_user.id, post_id: @post.id, notified_type: "コメント")
  end
end

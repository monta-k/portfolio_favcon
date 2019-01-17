class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :correct_user, only: [:destroy]

  def new
    @track = params[:track]
    @post = current_user.posts.build if user_signed_in?
    @posts = Post.where(trackId: @track["trackId"])
  end

  def create
    post = current_user.posts.build(post_params)
    if post.save
      flash[:notice] = "投稿が完了しました。"
      redirect_to request.referrer
    else
      flash[:alert] = "投稿に失敗しました。"
      redirect_to request.referrer
    end
  end

  def destroy
    @post.destroy
    redirect_to request.referrer || root_url
  end

  def show
  end

  private

  def post_params
    params.require(:post).permit(:content, :artistName, :artistId, :trackName, :trackId, :collectionId, :track_type, :genre)
  end

  def correct_user
    @post = Post.find(params[:id])
    redirect_to root_path unless @post.user == current_user
  end
end

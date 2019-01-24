class PostsController < ApplicationController
  POSTS_PER_PAGE = 6
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :correct_user, only: [:destroy]

  def new
    @track = params[:track]
    @post = current_user.posts.build if user_signed_in?
    @posts = Post.where(trackId: @track["trackId"]).order(created_at: :desc).page(params[:page]).per(POSTS_PER_PAGE)
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
    params.require(:post).permit(:content, :artistName, :artistId, :trackName, :trackId, :collectionId, :track_type, :genre, :artwork)
  end

  def correct_user
    @post = Post.find(params[:id])
    redirect_to root_path unless @post.user == current_user
  end
end

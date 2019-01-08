class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def new
    @track = params[:track]
    @post = current_user.posts.build if user_signed_in?
    @posts = Post.where(trackId: @track["trackId"])
  end

  def create
    post = current_user.posts.build(post_params)
    if post.save
      redirect_to user_path(current_user)
    else
      redirect_to request.referrer
    end
  end

  private

  def post_params
    params.require(:post).permit(:content, :artistName, :artistId, :trackName, :trackId, :collectionId, :track_type, :genre)
  end
end

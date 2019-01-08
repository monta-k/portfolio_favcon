class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def new
    @track = params[:track]
    @post = current_user.posts.build if user_signed_in?
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to user_path(current_user)
    else
      redirect_to request.referrer
    end
  end

  private

  def post_params
    params.require(:post).permit(:content, :artistName, :artistId, :trackName, :trackId, :track_type, :genre)
  end
end

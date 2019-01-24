class MovieController < ApplicationController
  POSTS_PER_PAGE = 6

  def index
    if params[:q]
      @search_word = params[:q]
      @movie_lists = SearchMovie.search_by_title(params[:q])
    else
      @posts = Post.where(track_type: 0).includes(:user).order(created_at: :desc).page(params[:page]).per(POSTS_PER_PAGE)
    end
  end
end

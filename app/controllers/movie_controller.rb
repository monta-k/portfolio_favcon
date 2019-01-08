class MovieController < ApplicationController
  def index
    if params[:q]
      @search_word = params[:q]
      @movie_lists = SearchMovie.search_by_title(params[:q])
    else
      @posts = Post.where(track_type: 0)
    end
  end
end

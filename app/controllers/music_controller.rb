class MusicController < ApplicationController
  POSTS_PER_PAGE = 6

  def index
    if params[:q]
      @search_word = params[:q]
      @artist_lists = SearchMusic.search_by_artist(params[:q])
    elsif params[:artist_id]
      @album_lists = LookupMusic.search_by_artist(params[:artist_id])
      @artist_name = @album_lists.first["artistName"]
      @posts = Post.where(artistId: params[:artist_id]).includes(:user).order(created_at: :desc).page(params[:page]).per(POSTS_PER_PAGE)
    elsif params[:album_id]
      @song_lists = LookupMusic.search_by_album(params[:album_id])
      @album_name = @song_lists.first["collectionName"]
      @posts = Post.where(collectionId: params[:album_id]).includes(:user).order(created_at: :desc).page(params[:page]).per(POSTS_PER_PAGE)
    else
      @posts = Post.where(track_type: 1).includes(:user).order(created_at: :desc).page(params[:page]).per(POSTS_PER_PAGE)
    end
  end
end

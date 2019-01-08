class MusicController < ApplicationController
  def index
    if params[:q]
      @search_word = params[:q]
      @artist_lists = SearchMusic.search_by_artist(params[:q])
    elsif params[:artist_id]
      @album_lists = LookupMusic.search_by_artist(params[:artist_id])
      @artist_name = @album_lists.first["artistName"]
      @posts = Post.where(artistId: params[:artist_id]).order(created_at: :desc)
    elsif params[:album_id]
      @song_lists = LookupMusic.search_by_album(params[:album_id])
      @album_name = @song_lists.first["collectionName"]
      @posts = Post.where(collectionId: params[:album_id]).order(created_at: :desc)
    else
      @posts = Post.where(track_type: 1).order(created_at: :desc)
    end
  end
end

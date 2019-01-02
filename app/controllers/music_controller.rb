class MusicController < ApplicationController
  def index
    if params[:q]
      @search_word = params[:q]
      @artist_lists = SearchMusic.search_by_artist(params[:q])
    elsif params[:artist_id]
      @album_lists = LookupMusic.search_by_artist(params[:artist_id])
    elsif params[:album_id]
      @song_lists = LookupMusic.search_by_album(params[:album_id])
    end
  end
end

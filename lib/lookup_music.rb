require 'itunes-search-api'

class LookupMusic
  def self.search_by_artist(artist_id)
    artist_lists = []
    search_results = ITunesSearchAPI.lookup(:id => artist_id, :entity => "album", :lang => 'ja_jp', :country => 'jp')
    search_results.each do |result|
      artist_lists << result
    end
    artist_lists
  end

  def self.search_by_album(album_id)
    album_lists = []
    search_results = ITunesSearchAPI.lookup(:id => album_id, :entity => "song", :lang => 'ja_jp', :country => 'jp')
    search_results.each do |result|
      album_lists << result
    end
    album_lists
  end
end

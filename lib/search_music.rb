require 'itunes-search-api'

class SearchMusic
  def self.search_by_artist(artist)
    artist_lists = []
    search_results = ITunesSearchAPI.search(:term => artist, :country => 'jp', :media   => 'music',:entity => "musicArtist", :attribute => 'artistTerm', :lang    => 'ja_jp', :limit => 200)
    search_results.each do |result|
      artist_lists << result
    end
    artist_lists
  end
end

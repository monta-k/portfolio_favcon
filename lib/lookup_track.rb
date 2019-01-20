require 'itunes-search-api'

class LookupTrack
  def self.search_by_trackid(track_id, track_type)
    if track_type == "movie"
      result_track = ITunesSearchAPI.lookup(:id => track_id, :entity => "movie", :lang => 'ja_jp', :country => 'jp')
    elsif track_type == "music"
      result_track = ITunesSearchAPI.lookup(:id => track_id, :entity => "song", :lang => 'ja_jp', :country => 'jp')
    end
    result_track.first
  end
end

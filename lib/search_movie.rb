require 'itunes-search-api'

class SearchMovie
  def self.search_by_title(title)
    movie_lists = []
    search_results = ITunesSearchAPI.search(:term => title, :country => 'jp', :media   => 'movie', :entity => "movie", :attribute => 'movieTerm', :lang    => 'ja_jp', :limit => 200)
    search_results.each do |result|
      movie_lists << result
    end
    movie_lists
  end
end

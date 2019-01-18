FactoryBot.define do
  factory :movie_post, class: "Post" do
    track_type { 0 }
    artistName { "movie_star" }
    trackName { "movie_track" }
    trackId { "123" }
    genre { "action" }
    content { "映画感想" }
  end

  factory :music_post, class: "Post" do
    track_type { 1 }
    artistName { "music_star" }
    trackName { "music_track" }
    trackId { "456" }
    genre { "rock" }
    content { "音楽感想" }
  end
end

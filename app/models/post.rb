class Post < ApplicationRecord
  belongs_to :user

  enum track_type: { movie: 0, music: 1 }
  validates :artistName, presence: true
  validates :artistId, presence: true
  validates :trackName, presence: true
  validates :trackId, presence: true
  validates :genre, presence: true
  validates :content, presence: true, length: { maximum: 250 }
end

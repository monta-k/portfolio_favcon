class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy

  enum track_type: { movie: 0, music: 1 }
  validates :artistName, presence: true
  validates :trackName, presence: true
  validates :trackId, presence: true
  validates :genre, presence: true
  validates :content, presence: true, length: { maximum: 400 }

  def liked_by(user)
    Like.find_by(user_id: user.id, post_id: id)
  end
end

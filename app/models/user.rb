class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :notifications, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum sex: { 男性: 1, 女性: 2 }

  validates :username, presence: true, length: { maximum: 20 }
  mount_uploader :image, ImageUploader

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def feed
    following_ids = Relationship.where(follower_id: id).select(:followed_id)
    Post.where(user: following_ids).or(Post.where(user: self))
  end
end

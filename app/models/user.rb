class User < ApplicationRecord
  has_many :posts
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum sex: { 男性: 1, 女性: 2 }

  validates :username, presence: true, length: { maximum: 20 }
end

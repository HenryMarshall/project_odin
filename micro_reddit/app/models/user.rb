class User < ActiveRecord::Base
  validates :username, presence: true, length: { maximum: 25 }
  has_many :posts
  has_many :comments
end

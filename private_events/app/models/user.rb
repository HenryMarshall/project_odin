class User < ActiveRecord::Base
  has_many :events, foreign_key: "creator_id"
  # validate that a users username is unique

end

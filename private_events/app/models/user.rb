class User < ActiveRecord::Base
  has_many :events, foreign_key: "creator_id"
  
  has_many :invitations, foreign_key: "attended_event_id"
  has_many :attended_events, through: :invitations
  # validate that a users username is unique

end

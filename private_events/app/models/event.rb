class Event < ActiveRecord::Base
  belongs_to :creator, class_name: "User"

  has_many :invitations, foreign_key: "attendee_id"
  has_many :attendees, through: :invitations
  # validate that event has a creator and description

end

class Event < ActiveRecord::Base
  # belongs_to :user
  belongs_to :creator, class_name: "User"
  # validate that event has a creator and description

end

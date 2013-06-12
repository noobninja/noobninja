class Meeting < ActiveRecord::Base
  belongs_to :lesson
  attr_accessible :adjourned, :booked, :capacity, :duration, :start_time
end

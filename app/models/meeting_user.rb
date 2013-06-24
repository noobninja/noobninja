class MeetingUser < ActiveRecord::Base
  belongs_to :meeting
  belongs_to :user
  # attr_accessible :title, :body
end

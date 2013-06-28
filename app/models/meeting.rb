class Meeting < ActiveRecord::Base
  belongs_to :lesson
  has_many :meeting_users
  has_many :users, through: :meeting_users
  attr_accessible :adjourned, :booked, :capacity, :duration, :start_time

  validates :start_time, presence: true

  def start_time=(input)
    zone = self.lesson.user.time_zone
    write_attribute :start_time, input.class == DateTime ? input : ActiveSupport::TimeZone[zone].parse(input).utc
  end
end

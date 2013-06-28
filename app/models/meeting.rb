class Meeting < ActiveRecord::Base
  belongs_to :lesson
  has_many :meeting_users
  has_many :users, through: :meeting_users
  attr_accessible :adjourned, :booked, :capacity, :duration, :start_time

  validates :start_time, presence: true

  def start_time=(input)
    write_attribute :start_time, input.class == DateTime ? input : Chronic.parse(input, now: Time.zone.now)
  end
end

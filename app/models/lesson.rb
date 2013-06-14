class Lesson < ActiveRecord::Base
  acts_as_taggable

  belongs_to :user
  has_many :meetings, order: 'meetings.start_time'

  attr_accessible :amount, :description, :name, :tag_list, :type

  scope :with_available_meetings, -> { includes(:user, :meetings).where("meetings.booked = ? AND meetings.start_time >= ?", false, Time.zone.now).order("meetings.start_time") }

  def available_meetings
    meetings.where("meetings.start_time >= ?", Time.zone.now)
  end

  # def booked?
  #   meetings.where("meetings.booked = ?", false).blank?
  # end

  # def inactive?
  #   meetings.where("meetings.start_time >= ?", Time.zone.now).blank?
  # end
end

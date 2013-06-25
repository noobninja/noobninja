class Lesson < ActiveRecord::Base
  acts_as_taggable

  belongs_to :user
  has_many :meetings, order: 'meetings.start_time'
  accepts_nested_attributes_for :meetings, allow_destroy: true

  attr_accessible :amount, :booked, :description, :name, :tag_list, :type, :meetings_attributes

  validates :name, presence: true
  validates :amount, presence: true

  scope :with_available_meetings, -> { includes(:user, :meetings).where("meetings.booked = ? AND meetings.start_time >= ?", false, Time.zone.now).order("meetings.start_time") }

  def available_meetings
    meetings.where("meetings.start_time >= ?", Time.zone.now)
  end

  def cost
    amount / 100
  end
end

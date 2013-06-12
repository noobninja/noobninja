class Lesson < ActiveRecord::Base
  acts_as_taggable

  belongs_to :user
  has_many :meetings, order: 'meetings.start_time'

  attr_accessible :amount, :description, :name, :tag_list, :type
end

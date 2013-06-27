class Donation < ActiveRecord::Base
  belongs_to :user
  belongs_to :lesson
  attr_accessible :charity, :amount, :via_user_id, :counted, :lesson_id
end

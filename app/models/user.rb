class User < ActiveRecord::Base
  acts_as_taggable
  mount_uploader :image, ImageUploader

  has_many :lessons
  has_many :offers
  has_many :requests
  has_one :membership
  has_many :meeting_users
  has_many :users, through: :meeting_users

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :name, :first_name, :last_name, :username, :description, :image, :image_cache,
                  :tag_list, :time_zone, :member, :donations

  validates :name, presence: true
  validates :description, presence: true
  validates :description, presence: true
  validates_inclusion_of :time_zone, :in => ActiveSupport::TimeZone.zones_map { |m| m.name }, :message => "is not a valid Time Zone"

  def name=(string)
    name = string.split(' ', 2)
    write_attribute :name, string
    write_attribute :first_name, name.first
    write_attribute :last_name, name.last if string.length > 1
  end

  def member?
    membership.present?
  end

  def student?
    membership.present? && (membership.plan_id > 1)
  end

  def teacher?
    membership.present? && membership.plan_id == 1
  end

  def donations_in_dollars
    donations / 100
  end
end

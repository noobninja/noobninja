class User < ActiveRecord::Base
  acts_as_taggable

  has_many :lessons
  has_many :offers
  has_many :requests

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :first_name, :last_name, :username, :description, :image, :tag_list, :time_zone

  validates :first_name, presence: true
  validates :description, presence: true
  validates :description, presence: true
  validates_inclusion_of :time_zone, :in => ActiveSupport::TimeZone.zones_map { |m| m.name }, :message => "is not a valid Time Zone"

  def first_name=(name)
    string = name.split(' ', 2)
    write_attribute :first_name, string.first
    write_attribute :last_name, string.last if string.length > 1
  end
end

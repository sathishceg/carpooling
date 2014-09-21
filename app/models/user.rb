class User < ActiveRecord::Base
  authenticates_with_sorcery!

  attr_accessible :email, :alias, :password, :password_confirmation
  attr_accessible :email, :password, :password_confirmation
  has_one :user_profile
  has_many :trips
  has_many :bookings
  has_many :trips, :through => :bookings
  has_many :ratings

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates :email, :presence => true, :email => true
  validates :password, :password => true
  validates_uniqueness_of :email,:alias
end

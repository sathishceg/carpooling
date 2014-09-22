class Location < ActiveRecord::Base
  geocoded_by :address
	after_validation :geocode
  has_many :trips
  
  acts_as_gmappable

  def gmaps4rails_address

    "#{self.address}"
  end
end

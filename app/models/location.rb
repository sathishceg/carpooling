class Location < ActiveRecord::Base
  geocoded_by :address
	after_validation :geocode
  has_many :trips
  
  acts_as_gmappable

  def gmaps4rails_address
  #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    "#{self.address}"
  end
end

class Trip < ActiveRecord::Base
  belongs_to :start_location , :class_name => 'Location', :foreign_key => "start_location_id"
  belongs_to :end_location , :class_name => 'Location', :foreign_key => "end_location_id"
  belongs_to :creator, :class_name => "User", :foreign_key => "created_by"
  has_many :bookings
  has_many :users, :through => :bookings

  accepts_nested_attributes_for:start_location
  accepts_nested_attributes_for:end_location

end


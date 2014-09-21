ActiveAdmin.register Booking do
  index do
  	column :id
  	column :user_id, :sortable => :user_id do |booking|
  		User.find(booking.user_id).alias
  	end
  	column "From", :trip_id, :sortable => :trip_id do |booking|
  		trip = Trip.find(booking.trip_id)
  		trip.start_location.address
  	end
  	column "To", :trip_id, :sortable => :trip_id do |booking|
  		trip = Trip.find(booking.trip_id)
  		trip.end_location.address
  	end
  	column :number_of_seats
  	column :created_at
  	default_actions
  end
end

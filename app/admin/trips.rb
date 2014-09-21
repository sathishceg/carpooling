ActiveAdmin.register Trip do
  index do
  	column :start_location_id, :sortable => :start_location_id do |trip|
  		trip.start_location.address
  	end
  	column :end_location_id, :sortable => :end_location_id do |trip|
  		trip.end_location.address
  	end
  	column :start_time
  	column :number_of_free_seats
  	column :fare
  	column :taxi_type, :sortable => :taxi_type do |trip|
  		if trip.taxi_type == 0 
    		"4 Personen"
   		elsif trip.taxi_type == 1
    		"6 Personen"
   		else 
     		"8 Personen"
   		end 
  	end 
  	column :created_by, :sortable => :created_by do |trip|
  		User.find(trip.created_by).alias
  	end
  	default_actions
  end
end

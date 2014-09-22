ActiveAdmin::Dashboards.build do

  section "Recent Created Trips" do
    table_for Trip.order("created_at desc").limit(5) do
      column :start_location_id, :sortable => :start_location_id do |trip|
        link_to trip.start_location.address, [:admin, trip] 
      end
      column :end_location_id, :sortable => :end_location_id do |trip|
        link_to trip.end_location.address, [:admin, trip]
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
    end
    strong { link_to "View All Trips", admin_trips_path }
  end


end

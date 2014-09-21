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


  # Define your dashboard sections here. Each block will be
  # rendered on the dashboard in the context of the view. So just
  # return the content which you would like to display.
  
  # == Simple Dashboard Section
  # Here is an example of a simple dashboard section
  #
  #   section "Recent Posts" do
  #     ul do
  #       Post.recent(5).collect do |post|
  #         li link_to(post.title, admin_post_path(post))
  #       end
  #     end
  #   end
  
  # == Render Partial Section
  # The block is rendered within the context of the view, so you can
  # easily render a partial rather than build content in ruby.
  #
  #   section "Recent Posts" do
  #     div do
  #       render 'recent_posts' # => this will render /app/views/admin/dashboard/_recent_posts.html.erb
  #     end
  #   end
  
  # == Section Ordering
  # The dashboard sections are ordered by a given priority from top left to
  # bottom right. The default priority is 10. By giving a section numerically lower
  # priority it will be sorted higher. For example:
  #
  #   section "Recent Posts", :priority => 10
  #   section "Recent User", :priority => 1
  #
  # Will render the "Recent Users" then the "Recent Posts" sections on the dashboard.

end

class AddStartLocationIdToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :start_location_id, :integer
  end
end

class AddEndLocationIdToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :end_location_id, :integer
  end
end

class DeleteStartAndEndLocation < ActiveRecord::Migration
def change
  remove_column :trips, :start_location_id
  remove_column :trips, :end_location_id

  drop_table :start_locations
  drop_table :end_locations
end
end

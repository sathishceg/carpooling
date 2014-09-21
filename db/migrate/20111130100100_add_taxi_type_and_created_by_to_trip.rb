class AddTaxiTypeAndCreatedByToTrip < ActiveRecord::Migration
  def change
    add_column :trips, :taxi_type, :integer
    add_column :trips, :created_by, :integer
  end
end

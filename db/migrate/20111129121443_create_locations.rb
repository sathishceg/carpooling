class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :address
      t.integer :latitude
      t.integer :longitude
      t.string :location_type

      t.timestamps
    end
  end
end

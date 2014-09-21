class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.datetime :start_time
      t.integer :number_of_free_seats
      t.decimal :fare

      t.timestamps
    end
  end
end

class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.integer :trip_id
      t.integer :user_id
      t.integer :number_of_seats

      t.timestamps
    end
  end
end

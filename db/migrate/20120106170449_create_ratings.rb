class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :user_id
      t.integer :rating_type
      t.text :comment

      t.timestamps
    end
  end
end

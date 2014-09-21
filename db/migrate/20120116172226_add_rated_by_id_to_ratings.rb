class AddRatedByIdToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :rated_by_id, :integer
  end
end

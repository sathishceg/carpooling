class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.string :forename
      t.string :surname
      t.timestamps
    end
    add_column :users, :user_profile_id, :integer
  end
end

class AddEnhancedUserProfileDefinition < ActiveRecord::Migration
  def change
    add_column :user_profiles, :title, :string
    add_column :user_profiles, :gender, :string
    add_column :user_profiles, :residence, :string
    add_column :user_profiles, :date_of_birth, :date
    add_column :user_profiles, :about_you, :text
  end
end

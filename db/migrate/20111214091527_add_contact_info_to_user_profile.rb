class AddContactInfoToUserProfile < ActiveRecord::Migration
  def change
    add_column :user_profiles, :contact_info, :text
  end
end

ActiveAdmin.register UserProfile do
  index do
  	column :id
  	column :forename
  	column :surname
  	column :contact_info
  	column :title
  	column :gender
  	column :residence
  	column :date_of_birth
  	column :about_you
  	default_actions
  end
end

ActiveAdmin.register User do
  index do
  	column :id
  	column :email
  	column :alias
  	column :created_at
  	column :updated_at
  	default_actions
  end
end

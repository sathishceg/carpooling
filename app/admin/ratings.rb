ActiveAdmin.register Rating do
  index do
  	column :id
  	column :rating_type, :sortable => :rating_type do |rating|
  		if rating.rating_type == 0 
    		"Positive"
   		else 
     		"Negative"
   		end 
  	end 
  	column :comment
  	#column "Rated By", :rated_by_id, :sortable => :rated_by_id do |rating|
  	#	User.find(rating.rated_by_id).alias
  	#end
  	column "Rated User", :user_id, :sortable => :user_id do |rating|
  		User.find(rating.user_id).alias
  	end
  	default_actions
  end
end

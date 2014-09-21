class UserProfilesController < ApplicationController
  before_filter :not_authenticated
  before_filter :is_logged_in_user, :only => [:edit, :update]


  def new
    @user_profile= UserProfile.new(:residence => "",:about_you => "", :title => "", :gender => "", :forename => "", :surname => "", :contact_info => "")


    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @location }
    end
  end

  def edit
    @user_profile = UserProfile.find(params[:id])
  end

  def update
    @user_profile = UserProfile.find(params[:id])
    respond_to do |format|

      # now update the trip
      if @user_profile.update_attributes(params[:user_profile])
        format.html { redirect_to user_path(User.find_by_user_profile_id(@user_profile.id)), notice: "Now that's what I call a nice profile'!" }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def is_logged_in_user
    @user_profile = UserProfile.find(params[:id])
    unless is_logged_in_user?(@user_profile)
      redirect_to User.find_by_user_profile_id(current_user.user_profile_id), :alert => "You can't edit a profile which is not yours! But hey, you got your own one, don't you?!'"
      false
    end
  end

end

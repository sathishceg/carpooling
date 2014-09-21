class UsersController < ApplicationController
  before_filter :not_authenticated, :only => [:show]

  def new
    @user = User.new
    @user_profile = UserProfile.new
  end

  def create
    @user = User.new(params[:user])
    @user_profile = UserProfile.new
    @user_profile.save!
    @user.user_profile_id = @user_profile.id
    if @user.save
      redirect_to trips_path, :notice => "You are signed up now! Just check your mails to activate your account!"
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @user_profile = UserProfile.find(@user.user_profile_id)
    @name = @user_profile.title.to_s + " " + @user_profile.forename.to_s + " " + @user_profile.surname.to_s
    @age = age(@user_profile.date_of_birth)
    if current_user != false
      @is_current_user = current_user.id == @user.id
    else
      @is_current_user = false
    end

    if@is_current_user
      @user_trips = Trip.find_all_by_created_by(@user.id)
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  def activate
    if @user = User.load_from_activation_token(params[:id])
      @user.activate!
      redirect_to(login_path, :notice => 'User was successfully activated.')
    else
      not_authenticated
    end
  end

  private

  def age(dob)
    unless dob == nil
      now = Time.now.utc.to_date
      return now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
    else
      return ""
    end
  end

end

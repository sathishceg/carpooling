class RatingsController < ApplicationController
  before_filter :not_authenticated, :except => [:index, :show]
  before_filter :get_user
  before_filter :has_user_already_rated?
  
  def index
    @ratings = @user.ratings.all
  end

  def show
    @rating = @user.ratings.find(params[:id])
  end

  def new
    @rating = @user.ratings.build
  end

  def edit
    @rating = @user.ratings.find(params[:id])
  end

  def create
    @rating = @user.ratings.build(params[:rating])
    @rating.rated_by_id = current_user.id

    if @rating.save
      redirect_to(@user, :notice => 'Rating was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @rating = @user.ratings.find(params[:id])

    if @rating.update_attributes(params[:rating])
      redirect_to(@rating, :notice => 'Rating was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @rating = @user.ratings.find(params[:id])
    @rating.destroy

    redirect_to(ratings_url)
  end
  
  protected
  
  def get_user
    @user = User.find_by_id(params[:user_id])
    redirect_to root_path unless @user
  end

  def has_user_already_rated?
    ratings = @user.ratings.all
    ratings.each do |rating|
      if rating.rated_by_id == current_user.id
        redirect_to @user, :alert => "Sorry, you've already rated this user." and return 
      end
    end
  end
end

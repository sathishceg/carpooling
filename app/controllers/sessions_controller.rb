class SessionsController < ApplicationController
  def new
  end

  def create
    user = login(params[:email],params[:password],params[:remember_me])

    if user
      user.alias = params[:alias]
      user.save
      redirect_back_or_to trips_path, :notice => "Let's go for a ride!"
    else
      flash.now.alert = "Sorry, but it seems like your email or password was invalid..possible?!"
      render :new
    end
  end

  def destroy
    logout
    redirect_to trips_path, :notice => "See you!"
  end

end

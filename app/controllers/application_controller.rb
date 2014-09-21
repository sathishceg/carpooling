class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :correct_user?

  protected
  def not_authenticated
    unless logged_in?
      redirect_to login_url, :alert => "You need to be logged in to view this page"
      false
    end
  end

  def correct_user?(trip)
    if logged_in?
          if trip[:created_by] == current_user.id
                return true
          end
      end
  end

  def is_logged_in_user?(user_profile)
    if logged_in?
          if User.find_by_user_profile_id(user_profile.id).id == current_user.id
                return true
          end
      end
  end
end

class UserMailer < ActionMailer::Base
  default from: "cabshareRoR@googlemail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.reset_password_email.subject
  #
  def reset_password_email(user)
    @user = user
    @url  = "http://0.0.0.0:3000/password_resets/#{user.reset_password_token}/edit"
    mail(:to => "#{user.email}",
          :subject => "Your password has been reset")
  end

  def activation_needed_email(user)
    @user = user
    @url  = "http://0.0.0.0:3000/users/#{user.activation_token}/activate"
    @edit_profile_url = "http://0.0.0.0:3000/user_profiles/#{@user.user_profile_id}/edit"
    mail(:to => "#{user.email}",
        :subject => "Welcome to cabshare")
  end

  def contact_info_for_creator_email(creator, booker, trip)#(hash)
    #@creator = hash[:creator]
    #@booker = hash[:booker]
    #@trip = hash[:trip]

    @creator = creator
    @booker = booker
    @trip = trip
    @booker_profile = UserProfile.find(@booker.user_profile_id)
    mail(:to => "#{creator.email}",
          :subject => "Your Trip was booked.")
  end

  def contact_info_for_booker_email(creator, booker, trip)
    @creator = creator
    @booker = booker
    @trip = trip
    @creator_profile = UserProfile.find(@creator.user_profile_id)

    mail(:to => "#{booker.email}",
          :subject => "Successfully booked a Trip")
  end
end

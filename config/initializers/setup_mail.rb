ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "googlemail.com",
  :user_name            => "cabshareRoR",
  :password             => "rubyrubyruby",
  :authentication       => "plain",
  :enable_starttls_auto => true
}
# Uncomment to use development mail-adress again
#require 'development_mail_interceptor'
#ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :tls => true,
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "localhost:3000",
  :user_name            => "connecttheory@gmail.com",
  :password             => "botnik2011",
  :authentication       => "plain",
  :enable_starttls_auto => true
}
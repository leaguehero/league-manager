# gmail configuration for sending emails
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  address:              'smtp.gmail.com',
  port:                 587,
  domain:               'league-hero.herokuapp.com',
  user_name:            ENV["LH_USERNAME"],
  password:             ENV["LH_PASSWORD"],
  authentication:       'plain',
  enable_starttls_auto: true
}

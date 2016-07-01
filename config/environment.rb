# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  :address => 'smtp.sendgird.net'
  :port => '587'
  :authentication => :plain,
  :user_name => ENV['SENDGRID_USERNAME'],
  :password => ENV['SNEDGRID_PASSWORD'],
  :domain => 'heroku.com',
  :enable_starttlis_auto => true
}

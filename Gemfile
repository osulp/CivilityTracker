source 'https://rubygems.org'

gem 'coffee-rails'
gem 'email_validator'
gem 'jquery-rails'
gem 'sqlite3'
gem 'rack-timeout'
gem 'rails', '4.2.0'
gem 'responders'
gem 'recipient_interceptor'
gem 'sass-rails', '~> 4.0.3'
gem 'simple_form', '3.1.0.rc1'
gem 'uglifier'
gem 'passenger'
gem 'bootstrap-sass'
# Geocoder for reverse geocoding.
gem 'geocoder'
# Draper for decorating
gem 'draper'
# Data tables
gem 'jquery-datatables-rails', :github => "rweng/jquery-datatables-rails"
# QR Code Generation
gem 'rqrcode_png'
gem 'dragonfly'
gem 'devise'
gem 'capybara'
gem 'tinymce-rails', '4.0.11'
group :development do
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'capistrano', '~> 2.0'
end

group :development, :test do
  gem 'awesome_print'
  gem 'byebug'
  gem 'factory_girl_rails'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 2.14.0'
  gem 'simplecov'
  gem 'coveralls', :require => false
end

group :test do
  gem 'poltergeist'
  gem 'database_cleaner'
  gem 'formulaic'
  gem 'shoulda-matchers', require: false
  gem 'timecop'
  gem 'webmock'
end

group :staging, :production do
  gem 'newrelic_rpm', '>= 3.7.3'
  gem 'mysql2'
end

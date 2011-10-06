source :rubygems

gem "rails", "3.1.1.rc1"

gem "rake",             "0.9.2"
gem "rack",             "1.3.3"
gem "jquery-rails",     "1.0.13"
gem "fancybox-rails",   "0.1.4"
gem "bitly",            "0.6.1"
gem "twitter",          "1.7.0"
gem "haml",             "3.1.2"
gem "friendly_id",      "3.3.0.1"
gem "omniauth",         "0.3.0.rc3"
gem "icalendar",        "1.1.5"
gem "ambience",         "0.3.1"
gem "activeadmin",      "0.3.2"
gem "thin",             "1.2.11"
gem "foreman",          "0.19.0"
gem "decent_exposure",  "1.0.1"
gem "geocoder",         "1.0.2"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem "compass",      "0.12.alpha.0"
  gem "sass-rails",   "3.1.0"
  gem "coffee-rails", "3.1.0"
  gem "uglifier",     "1.0.3"
end

group :production do
  gem "pg", "0.11.0" # env ARCHFLAGS="-arch x86_64" gem install pg
end

group :development do
  gem "heroku"
  gem "rb-fsevent", :require => false
  gem "guard-rspec"
  gem "growl_notify"
end

group :development, :test do
  gem "pry"
  gem "fuubar",       "0.0.3"
  gem "mocha",        "0.9.12"
  gem "sqlite3-ruby", "1.3.3", :require => "sqlite3"
  gem "rspec-rails",  "2.6.1"
  gem "capybara",     "1.1.1"
  gem "factory_girl", "1.3.3"
end

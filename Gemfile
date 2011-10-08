source :rubygems

gem "rails",            "3.1.1"

gem "rake",             "0.9.2"
gem "rack",             "1.3.3"
gem "jquery-rails",     "1.0.14"
gem "fancybox-rails",   "0.1.4"
gem "bitly",            "0.6.1"
gem "twitter",          "1.7.2"
gem "haml",             "3.1.3"
gem "friendly_id",      "3.3.0.1"
gem "omniauth",         "0.3.0"
gem "icalendar",        "1.1.6"
gem "ambience",         "1.0.0"
gem "activeadmin",      "0.3.2"
gem "thin",             "1.2.11"
gem "foreman",          "0.19.0"
gem "decent_exposure",  "1.0.1"
gem "geocoder",         "1.0.2"

group :assets do
  gem "compass",      "0.12.alpha.0"
  gem "sass-rails",   "3.1.4"
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
  gem "mocha",        "0.10.0"
  gem "sqlite3-ruby", "1.3.3", :require => "sqlite3"
  gem "rspec-rails",  "2.6.1"
  gem "capybara",     "1.1.1"
  gem "factory_girl", "2.1.2"
end

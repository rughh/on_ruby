source :rubygems

gem "rails",            "3.1.3"

gem "jquery-rails",     "1.0.19"
gem "haml",             "3.1.3"
gem "friendly_id",      "3.3.0.1"
gem "omniauth",         "1.0.1"
gem "omniauth-twitter", "0.0.7"
gem "icalendar",        "1.1.6"
gem "ambience",         "2.0.0"
gem "activeadmin",      "0.3.4"
gem "thin",             "1.3.1"
gem "foreman",          "0.26.1"
gem "decent_exposure",  "1.0.1"
gem "geocoder",         "1.0.5"
gem "acts_as_api",      "0.3.11"

group :assets do
  gem "compass",      "0.12.alpha.0"
  gem "sass-rails",   "3.1.5"
  gem "uglifier",     "1.1.0"
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
  gem "pry",          "0.9.7.4"
  gem "fuubar",       "0.0.6"
  gem "mocha",        "0.10.0"
  gem "sqlite3-ruby", "1.3.3", :require => "sqlite3"
  gem "rspec-rails",  "2.7.0"
  gem "factory_girl", "2.3.2"
end

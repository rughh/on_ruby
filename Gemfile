source :rubygems
ruby "1.9.3"

gem "rails",            "3.2.8"
gem "jquery-rails",     "2.0.2"
gem "friendly_id",      "4.0.4"
gem "omniauth",         "1.0.3"
gem "omniauth-twitter", "0.0.9"
gem "icalendar",        "1.1.6"
gem "activeadmin",      git: "https://github.com/gregbell/active_admin.git"
gem "sass-rails",       "3.2.4"
gem "slim-rails",       "1.0.3"
gem "meta_search",      ">= 1.1.0.pre"
gem "thin",             "1.3.1"
gem "foreman",          "0.41.0"
gem "decent_exposure",  "1.0.2"
gem "geocoder",         "1.1.1"
gem "acts_as_api",      "0.3.11"
gem "whitelabel",       "0.1.1"

group :assets do
  gem "compass",      "0.12.alpha.4"
  gem "uglifier",     "1.2.4"
  gem "coffee-rails", "3.2.2"
end

group :production do
  gem "pg",           "0.14.0"
  gem "dalli",        "2.1.0"
end

group :development do
  gem "heroku",       require: false
  gem "taps",         require: false
end

group :development, :test do
  gem "sqlite3"
  gem "pry-remote",   "0.1.1"
  gem "fuubar",       "1.0.0"
  gem "mocha",        "0.10.5"
  gem "rspec-rails",  "2.11.0"
  gem "factory_girl", "3.1.0"
end

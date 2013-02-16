source "http://bundler-api.herokuapp.com"
ruby "1.9.3"

gem "thin",         require: false
gem "foreman",      require: false

gem "rails",                  "3.2.12"
gem "slim-rails",             "1.1.0"
gem "redcarpet",              "2.2.2"
gem "friendly_id",            "4.0.9"
gem "omniauth",               "1.1.3"
gem "omniauth-twitter",       "0.0.14"
gem "omniauth-github",        "1.0.3"
gem "icalendar",              "1.2.1"
gem "meta_search",            ">= 1.1.0.pre"
gem "decent_exposure",        "2.1.0"
gem "geocoder",               "1.1.6"
gem "acts_as_api",            "0.4.1"
gem "whitelabel",             "0.2.0"
gem "newrelic_rpm",           "3.5.6.55"
gem "dalli",                  "2.6.2"
gem "exception_notification", "3.0.1"
gem "activeadmin",            "0.5.1"

# https://github.com/rails/sass-rails/issues/38
gem "sass-rails",             "3.2.6"
group :assets do
  gem "jquery-rails",         "2.2.1"
  gem "jquery_mobile_rails",  "1.2.0"
  gem "leaflet-rails",        "0.5.0"
  gem "compass-rails",        "1.0.3"
  gem "coffee-rails",         "3.2.2"
  gem "chosen-rails",         "0.9.11.2"
  gem "uglifier",             "1.3.0"
end

group :production do
  gem "pg",           "0.14.0"
end

group :development, :test, :caching do
  gem "sqlite3",            "1.3.7"
  gem "pry-remote",         "0.1.6"
  gem "pry-nav",            "0.2.3"
  gem "mocha",              "0.13.2", require: "mocha/api"
  gem "rspec-rails",        "2.12.2"
  gem "factory_girl",       "4.2.0"
  gem "timecop",            "0.5.9.2"
  gem "meta_request",       "0.2.1"
  gem "better_errors",      "0.6.0"
  gem "taps",               require: false
end

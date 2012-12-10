source "http://bundler-api.herokuapp.com"
ruby "1.9.3"

gem "thin",         require: false
gem "foreman",      require: false

gem "rails",                  "3.2.9"
gem "slim-rails",             "1.0.3"
gem "redcarpet",              "2.2.2"
gem "friendly_id",            "4.0.9"
gem "omniauth",               "1.1.1"
gem "omniauth-twitter",       "0.0.13"
gem "omniauth-github",        "1.0.3"
gem "icalendar",              "1.2.0"
gem "meta_search",            ">= 1.1.0.pre"
gem "decent_exposure",        "2.0.0"
gem "geocoder",               "1.1.4"
gem "acts_as_api",            "0.4.1"
gem "whitelabel",             "0.2.0"
gem "newrelic_rpm",           "3.5.0"
gem "dalli",                  "2.1.0"
gem "exception_notification", "3.0.0"

gem "activeadmin", git: "https://github.com/gregbell/active_admin.git", ref: "91c47b4fad79a1daa1e2bf070a120154b3b36818"

group :assets do
  gem "jquery-rails",         "2.1.3"
  gem "jquery_mobile_rails",  "1.2.0"
  gem "leaflet-rails",        "0.4.5"
  gem "compass",              "0.12.alpha.4"
  gem "sass-rails",           "3.2.5"
  gem "uglifier",             "1.3.0"
  gem "coffee-rails",         "3.2.2"
end

group :production do
  gem "pg",           "0.14.0"
end

group :development do
  gem "rack-mini-profiler", "0.1.22"
  gem "taps",               require: false
end

group :development, :test, :caching do
  gem "sqlite3",      "1.3.6"
  gem "pry-remote",   "0.1.6"
  gem "pry-nav",      "0.2.2"
  gem "mocha",        "0.12.7", require: "mocha_standalone"
  gem "rspec-rails",  "2.11.4"
  gem "factory_girl", "4.1.0"
  gem "timecop",      "0.5.3"
end

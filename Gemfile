source "http://rubygems.org"
ruby "2.0.0"

gem "thin",         require: false
gem "foreman",      require: false

gem "rails",                  "3.2.13"
gem "slim-rails",             "1.1.1"
gem "redcarpet",              "2.2.2"
gem "friendly_id",            "4.0.9"
gem "omniauth",               "1.1.4"
gem "omniauth-twitter",       "0.0.16"
gem "omniauth-github",        "1.1.0"
gem "icalendar",              "1.2.1"
gem "meta_search",            ">= 1.1.0.pre"
gem "decent_exposure",        "2.1.0"
gem "geocoder",               "1.1.6"
gem "acts_as_api",            "0.4.1"
gem "whitelabel",             "0.2.0"
gem "dalli",                  "2.6.2"
gem "exception_notification", "3.0.1"

# http://stackoverflow.com/questions/9307476/uninitialized-constant-sassrailssasstemplate
gem "sass-rails",             "3.2.6"
gem "activeadmin",            "0.6.0"

group :assets do
  gem "jquery-rails",         "2.1.4"
  gem "jquery_mobile_rails",  "1.2.0"
  gem "compass-rails",        "1.0.3"
  gem "coffee-rails",         "3.2.2"
  gem "chosen-rails",         "0.9.11.2"
  gem "uglifier",             "1.3.0"
end

group :production do
  gem "pg",                   "0.14.0"
end

group :development, :test do
  gem "sqlite3",            "1.3.7"
  gem "pry",                "0.9.12.1"
  gem "pry-remote",         "0.1.7"
  gem "pry-nav",            "0.2.3"
  gem "mocha",              "0.13.2", require: "mocha/api"
  gem "rspec-rails",        "2.13.1"
  gem "factory_girl",       "4.2.0"
  gem "timecop",            "0.6.1"
  gem "meta_request",       "0.2.1"
  gem "better_errors",      "0.8.0"
  gem "binding_of_caller",  "0.7.1"
  gem "taps",               require: false
end

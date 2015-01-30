source "http://rubygems.org"
ruby File.read('.ruby-version').chomp

gem "unicorn",                "~> 4.8.0"
gem "rails",                  "~> 4.2.0"
gem "responders",             "~> 2.0"
gem "rails-observers",        "~> 0.1.2"
gem "pg",                     "~> 0.17.1"
gem "rack-cache",             "~> 1.2"
gem "slim-rails",             "~> 3.0"
gem "redcarpet",              "~> 3.0"
gem "friendly_id",            "~> 5.1.0"
gem "ri_cal",                 "~> 0.8.8"
gem "decent_exposure",        "~> 2.3.1"
gem "geocoder",               "~> 1.1"
gem "acts_as_api",            "~> 0.4.2"
gem "whitelabel",             "~> 0.3"
gem "feedjira",               "~> 1.2"
gem "formtastic",             "~> 2.2.1"
gem "kaminari",               "~> 0.15.0"
gem "typus",                  github: "typus/typus"
gem "zero_push",              "~> 2.4.1"
gem "sucker_punch",           "~> 1.3.2"

# monitoring
gem "newrelic_rpm",           "~> 3.9"
gem "exception_notification", "~> 4.0.1"

# auth
gem "omniauth",               "~> 1.2.1"
gem "omniauth-twitter",       "~> 1.0.1"
gem "omniauth-github",        "~> 1.1.2"

# frontend
gem "jquery-rails",           "~> 3.0"
gem "chosen-rails",           "~> 1.3"
gem "sass-rails",             "~> 5.0.1"
gem "compass-rails",          "~> 2.0.4"
gem "coffee-rails",           "~> 4.0.1"
gem "font-awesome-rails",     "~> 4.0"
gem "uglifier",               "~> 2.5.0"

# peek
gem "peek",                   "~> 0.1.8"
gem "peek-pg",                "~> 1.1.0"
gem "peek-dalli",             "~> 1.1.2"
gem "peek-gc",                "~> 0.0.2"
gem "peek-git",               "~> 1.0.2"
gem "peek-performance_bar",   "~> 1.1.3"

group :production, :caching do
  gem "heroku-deflater",  "~> 0.5.3"
  gem "rails_12factor",   "~> 0.0.2"
  gem "dalli",            "~> 2.7.0"
  gem "kgio",             "~> 2.9.2"
  gem "lograge",          "~> 0.3.0"
end

group :development do
  gem "partially_useful"
end

group :development, :test do
  gem "database_cleaner"
  gem "spring"
  gem "spring-commands-rspec"
  gem "letter_opener"
  gem "faker"
  gem "pry-rails"
  gem "pry-remote"
  gem "pry-nav"
  gem "rspec-rails"
  gem "rspec-collection_matchers"
  gem "factory_girl_rails"
  gem "meta_request"
  gem "better_errors"
  gem "binding_of_caller"
  gem "quiet_assets"
  gem "codeclimate-test-reporter", require: false
end

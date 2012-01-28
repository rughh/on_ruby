source :rubygems

gem "rails",            "3.2.1"

gem "jquery-rails",     "2.0.0"
gem "haml",             "3.1.4"
gem "friendly_id",      "4.0.0"
gem "omniauth",         "1.0.2"
gem "omniauth-twitter", "0.0.7"
gem "icalendar",        "1.1.6"
gem "ambience",         "2.0.0"
gem "activeadmin",      :git => "https://github.com/gregbell/active_admin.git"
gem 'sass-rails',       "3.2.4"
gem 'meta_search',      ">= 1.1.0.pre"
gem "thin",             "1.3.1"
gem "foreman",          "0.36.1"
gem "decent_exposure",  "1.0.1"
gem "geocoder",         "1.1.0"
gem "acts_as_api",      "0.3.11"

group :assets do
  gem "compass",      "0.12.alpha.4"
  gem "uglifier",     "1.2.2"
end

group :production do
  gem "pg", "0.12.2" # env ARCHFLAGS="-arch x86_64" gem install pg
end

group :development do
  gem "heroku",       :require => false
  gem "rb-fsevent",   :require => false
  gem "guard-rspec",  :require => false
  gem "growl_notify", :require => false
end

group :development, :test do
  gem "pry",          "0.9.8"
  gem "fuubar",       "0.0.6"
  gem "mocha",        "0.10.0"
  gem "sqlite3-ruby", "1.3.3", :require => "sqlite3"
  gem "rspec-rails",  "2.8.1"
  gem "factory_girl", "2.3.2"
end

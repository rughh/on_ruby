source :rubygems

gem "rails", "~> 3.1.0"

gem "rake", "0.9.2"

gem "bitly", "~> 0.6.1"
gem "twitter", "~> 1.7.0"
gem "haml", "~> 3.1.2"
gem "sass-rails"
gem 'compass', :git => 'https://github.com/chriseppstein/compass.git', :branch => 'rails31'
gem "friendly_id", "~> 3.0"
gem "omniauth", "0.3.0.rc3"
gem "icalendar", "~> 1.1.5"
gem "ambience", "~> 0.3.1"
gem "activeadmin", "~> 0.3.1"
gem "thin", "~> 1.2.11"
gem "foreman", "~> 0.19.0"
gem "decent_exposure", "~> 1.0.1"
gem "geocoder", "~> 1.0.2"
gem 'will_paginate', '~> 3.0.pre4'

group :production do
  gem "pg", "~> 0.11.0" # env ARCHFLAGS="-arch x86_64" gem install pg
end

group :development do
  gem "ruby-debug19", :require => "ruby-debug", :platforms => :mri_19
  gem "heroku"
  gem 'rb-fsevent', :require => false
  gem 'guard-rspec'
end

group :development, :test do
  gem "fuubar", "~> 0.0.3"
  gem "mocha", "~> 0.9.12"
  gem "sqlite3-ruby", :require => "sqlite3"
  gem "rspec-rails", "~> 2.6.1"
  gem "remarkable_activemodel", "~> 4.0.0.alpha4"
  gem "remarkable_activerecord", "~> 4.0.0.alpha4"
  gem "factory_girl", "~> 1.3.3"
end

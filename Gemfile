source :rubygems

gem "rails", "~> 3.0.9"

gem "rake", "0.9.2"

gem "bitly", "~> 0.6.1"
gem "twitter", "~> 1.1.1"
gem "dalli", "~> 1.0.0"
gem "hpricot", "~> 0.8.3"
gem "haml", "~> 3.1.2"
gem "sass", "~> 3.1.1"
gem "will_paginate", "~> 3.0.pre2"
gem "friendly_id", "~> 3.0"
gem "compass", "~> 0.10.5"
gem "omniauth", "~> 0.2.0"
gem "icalendar", "~> 1.1.5"
gem "cancan", "~> 1.4.1"
gem "ambience", "~> 0.3.1"
gem "activeadmin", "~> 0.2.2"
gem "thin", "~> 1.2.11"
gem "foreman", "~> 0.19.0"
gem "decent_exposure", "~> 1.0.1"
gem "formtastic", "~> 1.2.4"

group :production do
  gem "pg", "~> 0.11.0" # env ARCHFLAGS="-arch x86_64" gem install pg
end

group(:development, :test) do
  gem "heroku", "~> 2.0.4"
  gem 'rb-fsevent', :require => false if RUBY_PLATFORM =~ /darwin/i
  gem 'guard-rspec'
  gem "fuubar", "~> 0.0.3"
  gem "mocha", "~> 0.9.12"
  gem "sqlite3-ruby", :require => "sqlite3"
  gem "ruby-debug19", :require => "ruby-debug", :platforms => :mri_19
  gem "rspec-rails", "~> 2.6.1"
  gem "remarkable_activemodel", "~> 4.0.0.alpha4"
  gem "remarkable_activerecord", "~> 4.0.0.alpha4"
  gem "factory_girl", "~> 1.3.3"
end

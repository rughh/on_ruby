source 'http://rubygems.org'
ruby '~> 2.4.2'

gem 'puma',                   '~> 3.6'
gem 'rails',                  '~> 5.0.6'
gem 'responders',             '~> 2.0'
gem 'rails-observers',        '~> 0.1.2' # 0.1.4 is broken https://github.com/rails/rails-observers/issues/60
gem 'pg',                     '~> 0.21.0'
gem 'rack-cache',             '~> 1.2'
gem 'slim-rails',             '~> 3.0'
gem 'redcarpet',              '~> 3.0'
gem 'omniauth',               '~> 1.8.1'
gem 'omniauth-twitter',       '~> 1.3.0'
gem 'omniauth-github',        '~> 1.3.0'
gem 'ri_cal',                 '~> 0.8.8'
gem 'decent_exposure',        '~> 3.0.2'
gem 'geocoder',               '~> 1.1'
gem 'acts_as_api',            '~> 1.0.1'
gem 'whitelabel',             '~> 0.3'
gem 'exception_notification', '~> 4.2.2'
gem 'feedjira',               git: 'https://github.com/feedjira/feedjira.git'
gem 'formtastic',             '~> 3.1.5'
gem 'kaminari',               '~> 1.1.1'
gem 'typus',                  git: 'https://github.com/typus/typus.git', branch: '5-0-unstable'
gem 'one_signal',             '~> 0.0.10'
gem 'link_thumbnailer',       '~> 3.3.2'
gem 'validate_url',           '~> 1.0.2'
# assets
gem 'jquery-rails'
gem 'sass-rails'
gem 'compass-rails'
gem 'coffee-rails'
gem 'font-awesome-rails'
gem 'uglifier'

group :production do
  gem 'dalli',            '~> 2.7.0'
  gem 'kgio',             '~> 2.11.1'
  gem 'lograge',          '~> 0.9.0'
  gem 'heroku-deflater',  '~> 0.5.3'
  gem 'rails_12factor',   '~> 0.0.2'
end

group :development do
  gem 'partially_useful'
  # gem 'quiet_assets'
end

group :development, :test do
  gem 'letter_opener'
  gem 'faker'
  gem 'byebug'
  gem 'rspec-rails'
  gem 'rspec-collection_matchers'
  gem 'factory_bot_rails'
  gem 'meta_request'
  gem 'better_errors'
  gem 'binding_of_caller'
end

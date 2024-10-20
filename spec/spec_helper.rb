ENV['RAILS_ENV']    ||= 'test'
ENV['SECRET_TOKEN'] ||= 'SECRET_TOKEN_TEST_b7c7374eb0285b87c0c1c61c2c5401b9f92dd59209713801743202c'

require File.expand_path('../config/environment', __dir__)
require 'rspec/rails'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |file| require file }

RSpec.configure do |config|
  config.include RequestHelper, type: :controller
  config.include RequestHelper, type: :request
  config.include KaminariHelper
  config.include GeocoderHelper
  config.include FactoryBot::Syntax::Methods
  config.include ActiveSupport::Testing::TimeHelpers

  # config.raise_errors_for_deprecations!
  config.infer_spec_type_from_file_location!
  config.use_transactional_fixtures = true
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

  config.before do
    I18n.locale = :de
    Whitelabel.label = Whitelabel.labels.first
    stub_geocoder
  end

  config.before(:each, type: :request) do
    host! 'hamburg.onruby.test'
  end

  config.before(:each, type: :controller) do
    set_subdomain
  end
end

include OnlineHelper

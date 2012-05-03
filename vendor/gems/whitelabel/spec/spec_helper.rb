require "whitelabel"

require "pry"

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
end

def fixture_path(name)
  File.expand_path "fixtures/#{name}", File.dirname(__FILE__)
end

Dummy = Struct.new(:label_id, :name)

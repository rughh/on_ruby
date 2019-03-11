require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module OnRuby
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = "Europe/Berlin"

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.locale = config.i18n.default_locale = :de
    config.i18n.fallbacks = [I18n.default_locale]
    config.i18n.available_locales = [:de, :en, :es]
    config.i18n.enforce_available_locales = true

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.log_tags = [:host]

    # Configure generators.
    config.generators do |g|
      g.template_engine :slim
      g.test_framework :rspec, :fixture => true, :views => false
      g.integration_tool :rspec, :fixture => true, :views => true
      g.fixture_replacement :factory_girl, :dir => "spec/support/factories"
      g.stylesheet_engine = :sass
    end
  end
end

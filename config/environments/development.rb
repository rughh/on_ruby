OnRuby::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = true

  # Configure Gmail for development-mails
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :address              => 'smtp.gmail.com',
    :port                 => 587,
    :domain               => 'hamburg.onruby.de',
    :user_name            => ENV['GMAIL_USER'],
    :password             => ENV['GMAIL_PASSWORD'],
    :authentication       => 'plain',
    :enable_starttls_auto => true
  }

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = false

  # Disable logging of asset requests
  config.assets.logger = false

  # Debug RJS
  # config.action_view.debug_rjs = true

  config.middleware.use "CookieDomain", ".onruby.dev"
end

# frozen_string_literal: true

OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_CONSUMER_KEY'], ENV['GOOGLE_CONSUMER_SECRET'], verify_iss: false
  provider :twitter, ENV['TWITTER_CONSUMER_KEY'], ENV['TWITTER_CONSUMER_SECRET']
  provider :github, {
    setup: proc do |env|
      host = env['SERVER_NAME']
      name = "OMNIAUTH_GITHUB_#{host[/.+\.(.+\..+)/, 1].delete('-').split('.').join('_').upcase}"

      env['omniauth.strategy'].options[:client_id]     = ENV["#{name}_KEY"]
      env['omniauth.strategy'].options[:client_secret] = ENV["#{name}_SECRET"]
    end
  }
end

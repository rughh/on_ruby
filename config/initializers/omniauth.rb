require_relative '../../lib/omni_auth/strategies/email'

OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, {
    verify_iss: false,
    setup: proc do |env|
      host = env['SERVER_NAME']
      tld = host[/(.+\.)?(.+\..+)/, 2]
      token = tld.delete('-').split('.').join('_').upcase
      name = "OMNIAUTH_GOOGLE_#{token}"

      if env.has_key?("#{name}_KEY") && env.has_key?("#{name}_SECRET")
        env['omniauth.strategy'].options[:client_id]     = ENV["#{name}_KEY"]
        env['omniauth.strategy'].options[:client_secret] = ENV["#{name}_SECRET"]
      else
        env['omniauth.strategy'].options[:client_id]     = ENV['GOOGLE_CONSUMER_KEY']
        env['omniauth.strategy'].options[:client_secret] = ENV['GOOGLE_CONSUMER_SECRET']
      end
    end
  }
  provider :twitter, ENV['TWITTER_CONSUMER_KEY'], ENV['TWITTER_CONSUMER_SECRET']
  provider :github, {
    setup: proc do |env|
      host = env['SERVER_NAME']
      tld = host[/(.+\.)?(.+\..+)/, 2]
      token = tld.delete('-').split('.').join('_').upcase
      name = "OMNIAUTH_GITHUB_#{token}"

      env['omniauth.strategy'].options[:client_id]     = ENV["#{name}_KEY"]
      env['omniauth.strategy'].options[:client_secret] = ENV["#{name}_SECRET"]
    end,
  }
  provider :email
end

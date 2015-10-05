OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_CONSUMER_KEY'], ENV['TWITTER_CONSUMER_SECRET']
  provider :github, {
    setup: Proc.new do |env|
      client_id, client_secret = env['rack.session']['omniauth_keys']
      env['omniauth.strategy'].options[:client_id]     = client_id
      env['omniauth.strategy'].options[:client_secret] = client_secret
    end
  }
end

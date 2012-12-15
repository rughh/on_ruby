OmniAuth.config.logger = Rails.logger

# production settings
OMNIAUTH_GITHUB_KEYS = Hash.new([ENV['GITHUB_CONSUMER_KEY'], ENV['GITHUB_CONSUMER_SECRET']])
OMNIAUTH_GITHUB_KEYS["rug-b.de"]           = [ENV['GITHUB_RUGB_CONSUMER_KEY'], ENV['GITHUB_RUGB_CONSUMER_SECRET']]
OMNIAUTH_GITHUB_KEYS["www.rug-b.de"]       = [ENV['GITHUB_RUGB_CONSUMER_KEY'], ENV['GITHUB_RUGB_CONSUMER_SECRET']]
OMNIAUTH_GITHUB_KEYS["colognerb.de"]       = [ENV['GITHUB_COLOGNERB_CONSUMER_SECRET'], ENV['GITHUB_COLOGNERB_CONSUMER_SECRET']]
OMNIAUTH_GITHUB_KEYS["www.colognerb.de"]   = [ENV['GITHUB_COLOGNERB_CONSUMER_SECRET'], ENV['GITHUB_COLOGNERB_CONSUMER_SECRET']]
# development settings
OMNIAUTH_GITHUB_KEYS["hamburg.onruby.dev"] = [ENV['GITHUB_DEV_ONRUBY_CONSUMER_KEY'], ENV['GITHUB_DEV_ONRUBY_CONSUMER_SECRET']]
OMNIAUTH_GITHUB_KEYS["rug-b.dev"]          = [ENV['GITHUB_DEV_RUGB_CONSUMER_KEY'], ENV['GITHUB_DEV_RUGB_CONSUMER_SECRET']]

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_CONSUMER_KEY'], ENV['TWITTER_CONSUMER_SECRET']
  provider :github, {
    setup: Proc.new do |env|
      client_id, client_secret = OMNIAUTH_GITHUB_KEYS[env['SERVER_NAME']]
      env['omniauth.strategy'].options[:client_id]     = client_id
      env['omniauth.strategy'].options[:client_secret] = client_secret
    end
  }
end

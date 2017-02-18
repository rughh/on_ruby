# Be sure to restart your server when you modify this file.

if Rails.env.production?
  Rails.application.config.session_store :redis_store, servers: "#{ENV['REDIS_URL']}/0/session", key: '_on_ruby_session'
else
  Rails.application.config.session_store :cookie_store, key: '_on_ruby_session'
end

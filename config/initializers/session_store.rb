# TODO: this probably causes quite some trouble, but according to what i've read,
# you need to specifiy the domain to allow cookies to be shared between subdomains.
# http://stackoverflow.com/a/10403338/279024 [dh, 2012-05-13]
domain = Rails.env.production? ? "onruby.de" : "onruby.dev"
OnRuby::Application.config.session_store :cookie_store, key: "_on_ruby_session", domain: domain


# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# OnRuby::Application.config.session_store :active_record_store

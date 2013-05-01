require "whitelabel_translation"
require "usergroup"

TLD = Rails.env.development? ? 'onruby.dev' : 'onruby.de'

Whitelabel.from_file Rails.root.join("config/whitelabel.yml")

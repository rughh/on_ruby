# frozen_string_literal: true

if Rails.env.development?
  Slim::Engine.set_options pretty: true
end

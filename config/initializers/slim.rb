if Rails.env.development?
  Slim::Engine.set_default_options pretty: true
end

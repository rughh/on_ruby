Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, '7XHDpX5zQtdGcQMdeKshXw', 'zQ7jlbiLuZwVqHnJ6VahnUriNcPo1GrjPeLim1AVMU'
  # provider :facebook, 'APP_ID', 'APP_SECRET'
  # provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'
end

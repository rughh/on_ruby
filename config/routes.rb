OnRuby::Application.routes.draw do
  resource :sitemap, only: :show

  resources :users do
    get :calendar, on: :member
  end

  resources :locations do
    get :none, on: :collection
  end

  resources :events do
    resources :materials
    resources :topics
    resources :participants
  end

  resources :topics do
    resources :likes
  end

  scope '/auth' do
    get '/:provider/callback',       to: 'sessions#create'
    get '/failure',                  to: 'sessions#failure'
    get '/destroy_session',          to: 'sessions#destroy',  as: :destroy_session
    get '/login/:provider',          to: 'sessions#auth',     as: :auth
    get '/offline_login/:nickname',  to: 'sessions#offline_login' if Rails.env.development?
  end

  constraints MainDomainConstraint.new do
    get '/', to: 'labels#index', as: :labels
  end

  get '/api', to: 'api#index'
  get '/styleguide(/:action)', controller: 'styleguide'
  root to: "home#index"

  mount Peek::Railtie => '/peek'

  match '/redirect-image.png', via: :all, to: -> (env) { [302, {"Location" => "https://jimdo-pilbox.herokuapp.com/?w=400&h=200&mode=clip&op=rotate&deg=90&url=http://hamburg.onruby.de/assets/labels/hamburg-a3d99018039599ae66a26b530adbbf2d.png"}, []] }
  match '*path.php', via: :all, to: -> (env) { [302, {"Location" => "http://www.youporn.com/"}, ["fuck yourself!"]] }
  match '*path', via: :all, constraints: -> (request) { request.path !~ %r[\A/admin] }, to: -> (env) { [404, {"Content-Type" => "text/html"}, ["not found"]] }
end

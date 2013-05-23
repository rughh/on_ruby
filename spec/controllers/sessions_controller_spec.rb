require 'spec_helper'

describe SessionsController do
  before { set_subdomain }

  context "GET :create" do
    before { request.env['omniauth.auth'] = TWITTER_AUTH_HASH }

    it "renders the :index template" do
      get :create, provider: :twitter
      controller.should be_signed_in
      response.should redirect_to(root_path)
    end
  end

  context "GET :auth" do
    let(:key)     { 'kkk' }
    let(:secret)  { 'sss' }

    before do
      ENV['OMNIAUTH_TWITTER_ONRUBY_DEV_KEY']    = key
      ENV['OMNIAUTH_TWITTER_ONRUBY_DEV_SECRET'] = secret
    end

    it "sets omniauth session options in the :auth action" do
      get :auth, provider: :twitter
      controller.session[:omniauth_keys].should eql([key, secret])
      response.should redirect_to('/auth/twitter')
    end
  end
end

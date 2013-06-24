require 'spec_helper'

describe SessionsController do
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

  context "GET :failure" do
    it "handles failure modes" do
      get :failure
      expect(response).to redirect_to(root_path)
      flash[:alert].should_not be_nil
    end
  end

  context "GET :auth" do
    it "handles different providers" do
      get :auth, provider: :twitter
      expect(response).to redirect_to('/auth/twitter')
      controller.session[:omniauth_keys].should_not be_nil
    end
  end

  context "GET :destroy" do
    it "destroys a user session" do
      get :destroy
      expect(response).to redirect_to(root_path)
      flash[:notice].should_not be_nil
    end
  end
end

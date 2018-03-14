require 'spec_helper'

describe SessionsController do
  context 'GET :create' do
    before { request.env['omniauth.auth'] = TWITTER_AUTH_HASH }

    it 'renders the :index template' do
      get :create, provider: :twitter
      expect(controller.send(:signed_in?)).to be_truthy
      expect(response).to redirect_to(root_path)
    end

    it 'rescues from duplicate nicknames' do
      create(:user, nickname: 'phoet')

      get :create, provider: :twitter
      expect(controller.send(:signed_in?)).to be_falsy
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to match('bereits vergeben')
    end
  end

  context 'GET :auth' do
    let(:key)     { 'kkk' }
    let(:secret)  { 'sss' }

    before do
      ENV['OMNIAUTH_TWITTER_ONRUBY_TEST_KEY']    = key
      ENV['OMNIAUTH_TWITTER_ONRUBY_TEST_SECRET'] = secret
    end

    it 'sets omniauth session options in the :auth action' do
      get :auth, provider: :twitter
      expect(controller.session[:omniauth_keys]).to eql([key, secret])
      expect(response).to redirect_to('/auth/twitter')
    end
  end

  context 'GET :failure' do
    it 'handles failure modes' do
      get :failure
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to_not be_nil
    end
  end

  context 'GET :auth' do
    it 'handles different providers' do
      get :auth, provider: :twitter
      expect(response).to redirect_to('/auth/twitter')
      expect(controller.session[:omniauth_keys]).to_not be_nil
    end
  end

  context 'GET :destroy' do
    it 'destroys a user session' do
      get :destroy
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to_not be_nil
    end
  end
end

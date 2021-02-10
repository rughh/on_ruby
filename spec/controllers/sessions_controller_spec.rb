require 'spec_helper'

describe SessionsController do
  context 'GET :create' do
    before { request.env['omniauth.auth'] = TWITTER_AUTH_HASH }

    it 'renders the :index template' do
      get :create, params: { provider: :twitter }
      expect(controller.send(:signed_in?)).to be_truthy
      expect(response).to redirect_to(root_path)
    end

    it 'rescues from duplicate nicknames' do
      create(:user, nickname: 'phoet')

      get :create, params: { provider: :twitter }
      expect(controller.send(:signed_in?)).to be_falsy
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to match('bereits vergeben')
    end
  end

  context 'GET :failure' do
    it 'handles failure modes' do
      get :failure
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).not_to be_nil
    end
  end

  context 'GET :destroy' do
    it 'destroys a user session' do
      get :destroy
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).not_to be_nil
    end
  end
end

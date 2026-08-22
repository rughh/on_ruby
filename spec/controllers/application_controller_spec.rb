# frozen_string_literal: true

require 'spec_helper'

describe ApplicationController do
  controller do
    def index
      render plain: 'ok'
    end

    def create
      authenticate!
      render plain: 'ok' unless performed?
    end
  end

  let(:user) { create(:user, :with_authorization) }

  context 'state 1 — fully anonymous' do
    it 'does not set _on_ruby_user' do
      get :index
      expect(cookies['_on_ruby_user']).to be_nil
    end
  end

  context 'state 2 — orphaned _on_ruby_user, no auth' do
    before { cookies['_on_ruby_user'] = '{"slug":"ghost","name":"Ghost"}' }

    it 'clears _on_ruby_user when authenticate! is triggered' do
      post :create
      expect(cookies['_on_ruby_user']).to be_blank
    end
  end

  context 'state 3 — valid session, no remember_me' do
    before { session[:user_id] = user.id }

    it 'authenticates the user via session' do
      post :create
      expect(response).to have_http_status(:ok)
    end

    it 'does not set remember_me' do
      post :create
      expect(cookies[:remember_me]).to be_nil
    end

    it 're-sets _on_ruby_user when absent' do
      get :index
      expect(cookies['_on_ruby_user']).to be_present
    end
  end

  context 'state 4 — remember_me valid, _on_ruby_user absent (migration)' do
    before { cookies.signed[:remember_me] = [user.id, user.salt] }

    it 're-sets _on_ruby_user on the next request' do
      get :index
      expect(cookies['_on_ruby_user']).to be_present
    end
  end

  context 'state 5 — returning user, both permanent cookies present' do
    before do
      cookies.signed[:remember_me] = [user.id, user.salt]
      cookies['_on_ruby_user'] = '{"slug":"testuser","name":"Test"}'
    end

    it 'does not overwrite _on_ruby_user' do
      original = cookies['_on_ruby_user']
      get :index
      expect(cookies['_on_ruby_user']).to eq(original)
    end
  end

  context 'state 6 — stale remember_me, _on_ruby_user absent' do
    before do
      cookies.signed[:remember_me] = [user.id, user.salt]
      user.destroy
    end

    it 'does not crash' do
      expect { get :index }.not_to raise_error
    end

    it 'leaves _on_ruby_user absent' do
      get :index
      expect(cookies['_on_ruby_user']).to be_blank
    end
  end

  context 'state 7 — stale remember_me and _on_ruby_user, user gone' do
    before do
      cookies.signed[:remember_me] = [user.id, user.salt]
      cookies['_on_ruby_user'] = '{"slug":"testuser","name":"Test"}'
      user.destroy
    end

    it 'clears _on_ruby_user when authenticate! is triggered' do
      post :create
      expect(cookies['_on_ruby_user']).to be_blank
    end
  end
end

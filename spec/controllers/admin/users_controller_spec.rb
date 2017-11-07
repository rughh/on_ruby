require 'spec_helper'

describe Admin::UsersController do
  context 'as admin' do
    before do
      allow(controller).to receive_messages(current_user: build(:admin_user))
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    context 'GET :new' do
      it 'hides this page' do
        get :new

        expect(response).to be_a_redirect
      end
    end

    context 'POST :create' do
      it 'hides this page' do
        post :create, {user: {}}

        expect(response).to have_http_status(422)
      end
    end
  end
end

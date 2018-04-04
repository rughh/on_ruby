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
      let(:data) { { user: attributes_for(:user) } }

      it 'hides this page' do
        expect {
          post :create, params: data
        }.not_to change(User, :count)
      end
    end
  end
end

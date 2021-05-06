require 'spec_helper'

describe SuperAdmin::EventsController do
  render_views

  let(:user) { build(:admin_user) }

  context 'with logged-in user' do
    before do
      allow(controller).to receive_messages(current_user: user)
    end

    context 'GET :index' do
      let!(:event) { create(:event) }

      it 'assign the events and renders the template' do
        get :index

        expect(response).to render_template(:index)
      end
    end
  end
end

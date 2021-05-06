require 'spec_helper'

describe Admin::EventsController do
  render_views

  let(:user) { build(:admin_user) }

  context 'with logged-in user' do
    before do
      allow(controller).to receive_messages(current_user: user)
    end

    context 'GET :index' do
      it 'assign the events and renders the template' do
        create(:event)

        get :index

        expect(response).to render_template(:index)
      end
    end
  end
end

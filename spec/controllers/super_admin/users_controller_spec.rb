require 'spec_helper'

describe SuperAdmin::UsersController do
  render_views

  before { set_subdomain }

  let(:user) { build(:admin_user) }
  let!(:event) do
    Whitelabel.with_label(Whitelabel.labels.first) do
      create(:event_with_participants)
    end
  end
  let!(:other_event) do
    Whitelabel.with_label(Whitelabel.labels.last) do
      create(:event_with_participants)
    end
  end

  context 'with logged-in user' do
    before do
      allow(controller).to receive_messages(current_user: user)
    end

    context 'GET :index' do
      it 'assign the users and renders the template' do
        get :index

        expect(response).to render_template(:index)
        expect(response.body).to include(event.participants.first.user.nickname)
        expect(response.body).to include(other_event.participants.first.user.nickname)
      end
    end
  end
end

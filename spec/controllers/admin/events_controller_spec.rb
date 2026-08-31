require 'spec_helper'

# TODO: Redundant. The full-stack equivalents now live in
# spec/requests/admin/events_spec.rb and spec/requests/admin/authorization_spec.rb
# (see RECOMMENDATIONS.md "Migrating to Request and System Tests"). Remove this
# controller spec once the request specs have proven stable.
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

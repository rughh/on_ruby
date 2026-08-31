require 'spec_helper'

# Every controller under `Admin::` inherits the `authenticate_admin_user!`
# before_action (see `UserHandling`). These specs pin down that guard.
describe 'Admin authorization', type: :request do
  let(:organizer) { create(:user) }

  def create_event_params
    { event: { name: 'Unauthorized', description: 'x', date: 1.day.from_now, user_id: organizer.id } }
  end

  context 'as an anonymous visitor' do
    it 'redirects the dashboard root to the site root with a flash' do
      get '/admin'

      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq(I18n.t('flash.only_admins'))
    end

    %w[
      /admin/events
      /admin/events/new
      /admin/locations
      /admin/topics
      /admin/jobs
      /admin/users
    ].each do |path|
      it "redirects GET #{path} to the site root" do
        get path

        expect(response).to redirect_to(root_path)
      end
    end

    it 'does not allow creating records' do
      expect { post '/admin/events', params: create_event_params }.not_to change(Event, :count)
      expect(response).to redirect_to(root_path)
    end
  end

  context 'as a signed-in non-admin user' do
    before { sign_in_via_github }

    it 'redirects away from the dashboard' do
      get '/admin'

      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq(I18n.t('flash.only_admins'))
    end

    it 'does not allow creating records' do
      expect { post '/admin/events', params: create_event_params }.not_to change(Event, :count)
    end
  end

  context 'as a signed-in admin user' do
    before { sign_in_via_github(admin: true) }

    it 'grants access to the dashboard' do
      get '/admin'

      expect(response).to have_http_status(:ok)
    end
  end
end

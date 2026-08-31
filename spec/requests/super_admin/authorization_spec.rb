require 'spec_helper'

# Everything under `SuperAdmin::` inherits `authenticate_super_admin_user!`,
# which requires `current_user.super_admin?` -- a stricter check than the
# `admin?` guard on the `Admin::` namespace.
describe 'Super admin authorization', type: :request do
  let(:organizer) { create(:user) }

  def create_event_params
    { event: { name: 'Unauthorized', description: 'x', date: 1.day.from_now, user_id: organizer.id } }
  end

  context 'as an anonymous visitor' do
    it 'redirects the dashboard root to the site root with a flash' do
      get '/super_admin'

      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq(I18n.t('flash.only_admins'))
    end

    it 'does not allow creating records' do
      expect { post '/super_admin/events', params: create_event_params }.not_to change(Event, :count)
      expect(response).to redirect_to(root_path)
    end
  end

  context 'as a plain admin (not a super admin)' do
    before { sign_in_via_github(admin: true) }

    it 'is still redirected away from the super admin dashboard' do
      get '/super_admin'

      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq(I18n.t('flash.only_admins'))
    end

    it 'does not allow creating records' do
      expect { post '/super_admin/events', params: create_event_params }.not_to change(Event, :count)
    end
  end

  context 'as a super admin' do
    before { sign_in_via_github(admin: true, super_admin: true) }

    it 'grants access to the dashboard' do
      get '/super_admin'

      expect(response).to have_http_status(:ok)
    end
  end
end

require 'spec_helper'

describe 'Super admin: event management', type: :request do
  before { sign_in_via_github(admin: true, super_admin: true) }

  let(:organizer) { create(:user) }
  let(:location) { create(:location) }

  describe 'GET /super_admin/events/new' do
    it 'renders the form' do
      get '/super_admin/events/new'

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /super_admin/events' do
    it 'creates an event' do
      expect do
        post '/super_admin/events', params: {
          event: {
            name: 'Super Meetup',
            description: 'A gathering',
            date: 2.weeks.from_now,
            user_id: organizer.id,
            location_id: location.id,
          },
        }
      end.to change(Event, :count).by(1)

      event = Event.order(:created_at).last
      expect(event).to have_attributes(name: 'Super Meetup', user: organizer, location: location)
      expect(response).to redirect_to(super_admin_event_path(event))
    end

    it 'does not create an invalid event' do
      expect do
        post '/super_admin/events', params: { event: { name: '', description: '', date: '', user_id: organizer.id } }
      end.not_to change(Event, :count)

      expect(response).not_to have_http_status(:redirect)
    end
  end

  describe 'PATCH /super_admin/events/:id' do
    it 'updates the event' do
      event = create(:event)

      patch super_admin_event_path(event), params: { event: { name: 'Renamed by super admin' } }

      expect(event.reload.name).to eq('Renamed by super admin')
      expect(response).to redirect_to(super_admin_event_path(event))
    end

    it 'can edit an event that belongs to another usergroup (unscoped)' do
      foreign = Whitelabel.with_label(Whitelabel.labels.last) do
        create(:event, label: Whitelabel.labels.last.label_id)
      end

      patch super_admin_event_path(foreign), params: { event: { name: 'Reached across labels' } }

      expect(foreign.reload.name).to eq('Reached across labels')
    end
  end

  describe 'DELETE /super_admin/events/:id' do
    it 'deletes the event' do
      event = create(:event)

      expect { delete super_admin_event_path(event) }.to change(Event, :count).by(-1)
      expect(response).to redirect_to(super_admin_events_path)
    end
  end
end

require 'spec_helper'

describe 'Admin: event management', type: :request do
  before { sign_in_via_github(admin: true) }

  let(:organizer) { create(:user) }
  let(:location) { create(:location) }

  describe 'GET /admin/events/new' do
    it 'renders the form' do
      get '/admin/events/new'

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /admin/events' do
    it 'creates an event and redirects to it' do
      expect do
        post '/admin/events', params: {
          event: {
            name: 'Rails Meetup',
            description: 'A monthly gathering',
            date: 2.weeks.from_now,
            user_id: organizer.id,
            location_id: location.id,
          },
        }
      end.to change(Event, :count).by(1)

      event = Event.order(:created_at).last
      expect(event).to have_attributes(name: 'Rails Meetup', user: organizer, location: location, label: 'hamburg')
      expect(response).to redirect_to(admin_event_path(event))
    end

    it 'does not create an invalid event' do
      expect do
        post '/admin/events', params: { event: { name: '', description: '', date: '', user_id: organizer.id } }
      end.not_to change(Event, :count)

      expect(response).not_to have_http_status(:redirect)
    end
  end

  describe 'GET /admin/events/:id/edit' do
    it 'renders the form' do
      event = create(:event)

      get edit_admin_event_path(event)

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PATCH /admin/events/:id' do
    it 'updates the event' do
      event = create(:event)

      patch admin_event_path(event), params: { event: { name: 'Renamed Event' } }

      expect(event.reload.name).to eq('Renamed Event')
      expect(response).to redirect_to(admin_event_path(event))
    end
  end

  describe 'DELETE /admin/events/:id' do
    it 'deletes the event' do
      event = create(:event)

      expect { delete admin_event_path(event) }.to change(Event, :count).by(-1)
      expect(response).to redirect_to(admin_events_path)
    end
  end
end

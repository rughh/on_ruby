require 'spec_helper'

describe EventsController do
  context 'GET :index' do
    let!(:event) { create(:event) }

    it 'assign the events and renders the template' do
      get :index
      expect(controller.events.first).to eql(event)
      expect(response).to render_template(:index)
    end

    context 'json' do
      it 'renders json' do
        allow(controller).to receive_messages(events: [event])

        get :index, params: { format: :json }
        expect(response.headers['Content-Type']).to eql('application/json; charset=utf-8')
        expect(JSON.parse(response.body)).to have(1).elements
      end
    end

    context 'xml' do
      render_views

      it 'renders xml' do
        allow(controller).to receive_messages(events: [event])

        get :index, params: { format: :xml }
        expect(response.headers['Content-Type']).to eql('application/xml; charset=utf-8')
        expect(response.body).to match(/rss/)
      end
    end
  end

  context 'GET :show' do
    let!(:event) { create(:full_event) }

    it 'assigns the event and renders the template' do
      get :show, params: { id: event.id }
      expect(controller.event).to eql(event)
      expect(response).to render_template(:show)
    end

    context 'json' do
      it 'renders json' do
        allow(controller).to receive_messages(event: event)
        get :show, params: { id: event, format: :json }
        expect(response.headers['Content-Type']).to eql('application/json; charset=utf-8')
        json = JSON.parse(response.body)

        participants_hash = event.participants.map do |p|
          {
            'id' => p.id,
            'user_id' => p.user_id,
            'event_id' => p.event_id,
          }
        end
        materials_hash = event.materials.map do |m|
          {
            'id' => m.id,
            'name' => m.name,
            'url' => m.url,
            'event_id' => m.event_id,
            'user_id' => m.user_id,
          }
        end
        topics_hash = event.topics.map do |t|
          {
            'id' => t.id,
            'event_id' => t.event_id,
            'user_id' => t.user_id,
            'name' => t.name,
            'description' => t.description,
            'user' => {
              'id' => t.user.id,
              'nickname' => t.user.nickname,
              'name' => t.user.name,
              'image' => t.user.image,
              'url' => t.user.url,
              'github' => t.user.github,
              'twitter' => t.user.twitter,
              'freelancer' => t.user.freelancer,
              'available' => t.user.available,
            },
          }
        end

        expect(json).to eql(
          'id' => event.id,
          'name' => event.name,
          'description' => event.description,
          'date' => event.date.strftime('%Y-%m-%dT%H:%M:%S.%L%:z'),
          'location_id' => event.location_id,
          'user_id' => event.user_id,
          'participants' => participants_hash,
          'topics' => topics_hash,
          'materials' => materials_hash,
          'location' => {
            'id' => event.location.id,
            'name' => event.location.name,
            'url' => event.location.url,
            'city' => event.location.city,
            'street' => event.location.street,
            'house_number' => event.location.house_number,
            'zip' => event.location.zip,
            'wheelmap_id' => event.location.wheelmap_id,
          }
        )
      end
    end

    context 'ics' do
      it 'renders ical' do
        allow(controller).to receive_messages(event: event)
        get :show, params: { id: event, format: :ics }
        expect(response.headers['Content-Type']).to eql('text/calendar; charset=utf-8')
        expect(response.body).to match('VCALENDAR')
      end
    end
  end
end

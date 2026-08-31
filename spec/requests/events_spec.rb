require 'spec_helper'

describe 'Events', type: :request do
  describe 'GET /events' do
    let!(:event) { create(:event) }

    it 'lists the events' do
      get events_path

      expect(response).to be_ok
      expect(response.body).to include(event.name)
    end

    it 'renders json' do
      get events_path(format: :json)

      expect(response.headers['Content-Type']).to eql('application/json; charset=utf-8')
      expect(JSON.parse(response.body).size).to eq(1)
    end

    it 'renders xml' do
      get events_path(format: :xml)

      expect(response.headers['Content-Type']).to eql('application/xml; charset=utf-8')
      expect(response.body).to match(/rss/)
    end
  end

  describe 'GET /events/:id' do
    let!(:event) { create(:full_event) }

    it 'shows the event' do
      get event_path(event)

      expect(response).to be_ok
      expect(response.body).to include(event.name)
    end

    it 'renders ical' do
      get event_path(event, format: :ics)

      expect(response.headers['Content-Type']).to eql('text/calendar; charset=utf-8')
      expect(response.body).to match('VCALENDAR')
    end

    it 'renders the full json representation' do
      get event_path(event, format: :json)

      expect(response.headers['Content-Type']).to eql('application/json; charset=utf-8')
      json = JSON.parse(response.body)

      participants_hash = event.participants.map do |p|
        { 'id' => p.id, 'user_id' => p.user_id, 'event_id' => p.event_id }
      end
      materials_hash = event.materials.map do |m|
        { 'id' => m.id, 'name' => m.name, 'url' => m.url, 'event_id' => m.event_id, 'user_id' => m.user_id }
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
          'virtual' => event.location.virtual,
        }
      )
    end
  end
end

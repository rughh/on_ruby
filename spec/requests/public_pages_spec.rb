require 'spec_helper'

describe 'Public pages smoke test' do
  let!(:event) { create(:event) }
  let!(:topic) { create(:topic, event:) }
  let!(:user)  { event.user }

  context 'GET /' do
    it 'renders the home page' do
      get '/'
      expect(response).to be_ok
    end
  end

  context 'GET /events' do
    it 'renders the events index' do
      get events_path
      expect(response).to be_ok
    end

    it 'renders as json' do
      get events_path(format: :json)
      expect(response).to be_ok
    end

    it 'renders as xml' do
      get events_path(format: :xml)
      expect(response).to be_ok
    end
  end

  context 'GET /events/:id' do
    it 'renders the event page' do
      get event_path(event)
      expect(response).to be_ok
    end

    it 'renders as ics' do
      get event_path(event, format: :ics)
      expect(response).to be_ok
    end
  end

  context 'GET /topics' do
    it 'renders the topics index' do
      get topics_path
      expect(response).to be_ok
    end
  end

  context 'GET /topics/:id' do
    it 'renders a topic page' do
      get topic_path(topic)
      expect(response).to be_ok
    end
  end

  context 'GET /users' do
    it 'renders the users index' do
      get users_path
      expect(response).to be_ok
    end
  end

  context 'GET /users/:id' do
    it 'renders a user page' do
      get user_path(user)
      expect(response).to be_ok
    end
  end

  context 'GET /locations' do
    it 'renders the locations index' do
      get locations_path
      expect(response).to be_ok
    end
  end

  context 'GET /locations/:id' do
    it 'renders a location page' do
      get location_path(event.location)
      expect(response).to be_ok
    end
  end
end

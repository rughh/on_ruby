require 'spec_helper'

describe 'Public pages smoke test' do
  Whitelabel.labels.each do |whitelabel|
    context "whitelabel: #{whitelabel.label_id}" do
      before { host! "#{whitelabel.label_id}.onruby.test" }

      let!(:location) { Whitelabel.with_label(whitelabel) { create(:location, label: whitelabel.label_id) } }
      let!(:event)    { Whitelabel.with_label(whitelabel) { create(:event, location:) } }
      let!(:topic)    { Whitelabel.with_label(whitelabel) { create(:topic, event:) } }

      it 'renders /' do
        get '/'
        expect(response).to be_ok
      end

      it 'renders /events' do
        get events_path
        expect(response).to be_ok
      end

      it 'renders /events as json' do
        get events_path(format: :json)
        expect(response).to be_ok
      end

      it 'renders /events as xml' do
        get events_path(format: :xml)
        expect(response).to be_ok
      end

      it 'renders /events/:id' do
        get event_path(event)
        expect(response).to be_ok
      end

      it 'renders /events/:id as ics' do
        get event_path(event, format: :ics)
        expect(response).to be_ok
      end

      it 'renders /topics' do
        get topics_path
        expect(response).to be_ok
      end

      it 'renders /topics/:id' do
        get topic_path(topic)
        expect(response).to be_ok
      end

      it 'renders /users' do
        get users_path
        expect(response).to be_ok
      end

      it 'renders /users/:id' do
        get user_path(event.user)
        expect(response).to be_ok
      end

      it 'renders /locations' do
        get locations_path
        expect(response).to be_ok
      end

      it 'renders /locations/:id' do
        get location_path(event.location)
        expect(response).to be_ok
      end
    end
  end
end

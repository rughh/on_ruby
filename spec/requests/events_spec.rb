require 'spec_helper'

describe 'Events' do
  let(:event) { create(:event) }

  context 'GET /events.son' do
    it 'renders valid json' do
      get event_path(event, format: :json)
      json = JSON.parse(response.body)
      expect(json['name']).to eql(event.name)
    end
  end
end

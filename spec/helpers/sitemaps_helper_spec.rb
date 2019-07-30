# typed: false
require 'spec_helper'

describe SitemapsHelper do
  let(:sitemap_urls) { ['http://hamburg.test.host/events/tesssstooo-999', 'http://hamburg.test.host/locations/blau-mobilfunk-gmbh-999', 'http://hamburg.test.host/'] }

  it 'returns the right urls' do
    location = create(:location, id: 999, name: 'blau mobilfunk gmbh')
    create(:event, name: 'tesssstooo', id: 999, label: 'hamburg', location: location)
    expect(helper.urls).to eql(sitemap_urls)
  end
end

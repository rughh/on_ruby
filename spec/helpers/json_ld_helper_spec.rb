require 'spec_helper'

describe JsonLdHelper do
  let(:location) { build(:location, id: 7, name: 'Cool Office', street: 'Bergstr.', house_number: '4', zip: '20095', city: 'Hamburg', lat: 53.5, long: 9.9) }
  let(:event) { build(:event, id: 123, name: 'awesome ottawa', date: '11.11.2011 19:00 +02:00', location:, remote_url: nil, limit: 40) }

  describe '#json_ld_event' do
    subject(:json) { helper.json_ld_event(event) }

    it 'describes a schema.org event' do
      expect(json).to include(
        '@context' => 'https://schema.org',
        '@type' => 'Event',
        '@id' => 'http://test.host/events/awesome-ottawa-123',
        'name' => 'awesome ottawa',
        'startDate' => '2011-11-11T18:00:00+01:00',
        'endDate' => '2011-11-11T20:00:00+01:00',
        'eventStatus' => 'https://schema.org/EventScheduled',
        'eventAttendanceMode' => 'https://schema.org/OfflineEventAttendanceMode',
        'maximumAttendeeCapacity' => 40
      )
    end

    it 'describes the venue as a place with address and coordinates' do
      expect(json['location']).to eq(
        [{
          '@type' => 'Place',
          '@id' => 'http://test.host/locations/cool-office-7',
          'name' => 'Cool Office',
          'url' => location.url,
          'address' => {
            '@type' => 'PostalAddress',
            'streetAddress' => 'Bergstr. 4',
            'postalCode' => '20095',
            'addressLocality' => 'Hamburg',
            'addressCountry' => 'DE',
          },
          'geo' => { '@type' => 'GeoCoordinates', 'latitude' => 53.5, 'longitude' => 9.9 },
        }]
      )
    end

    it 'uses the usergroup logo as image' do
      expect(json['image']).to match(%r{\Ahttp://test\.host/assets/.+\.png\z})
    end

    it 'offers free entry' do
      expect(json['offers']).to eq(
        '@type' => 'Offer',
        'price' => 0,
        'priceCurrency' => 'EUR',
        'availability' => 'https://schema.org/InStock',
        'url' => 'http://test.host/events/awesome-ottawa-123'
      )
    end

    it 'marks a full event as sold out' do
      allow(event).to receive(:closed?).and_return(true)

      expect(json['offers']['availability']).to eq('https://schema.org/SoldOut')
    end

    it 'renders the markdown description as plain text' do
      event.description = "Talks about **Ruby** and [Rails](https://rubyonrails.org) <b>tonight</b>\n\n* one\n* two"

      expect(json['description']).to eq("Talks about Ruby and Rails (https://rubyonrails.org) tonight\none\ntwo")
    end

    it 'lists each speaker once as performer' do
      user = build(:user, id: 5, nickname: 'phoet', name: 'Peter')
      event.topics << build(:topic, id: 9, name: 'Ruby rocks', user:, event:)
      event.topics << build(:topic, id: 10, name: 'Ruby rolls', user:, event:)

      expect(json['performer']).to eq(
        [{ '@type' => 'Person', '@id' => 'http://test.host/users/phoet-5', 'name' => 'Peter', 'url' => 'http://test.host/users/phoet-5' }]
      )
    end

    it 'names the usergroup as organizer' do
      expect(json['organizer']).to eq('@type' => 'Organization', 'name' => I18n.tw('name'), 'url' => 'http://test.host/')
    end

    it 'marks an event with a remote link as mixed without leaking the link' do
      event.remote_url = 'https://zoom.example/secret'

      expect(json['eventAttendanceMode']).to eq('https://schema.org/MixedEventAttendanceMode')
      expect(json['location'].last).to eq('@type' => 'VirtualLocation', 'url' => 'http://test.host/events/awesome-ottawa-123')
      expect(json.to_json).not_to include('secret')
    end

    it 'marks an event at a virtual venue as online' do
      event.location = build(:virtual_location, id: 8, name: 'Zoom')

      expect(json['eventAttendanceMode']).to eq('https://schema.org/OnlineEventAttendanceMode')
      expect(json['location']).to eq([{ '@type' => 'VirtualLocation', 'name' => 'Zoom', 'url' => 'http://test.host/locations/zoom-8' }])
    end

    it 'handles events with no location' do
      event.location = nil

      expect(json).not_to have_key('location')
    end

    it 'lists talks as sub-events with their speaker' do
      user = build(:user, id: 5, nickname: 'phoet', name: 'Peter')
      event.topics << build(:topic, id: 9, name: 'Ruby rocks', user:, event:)

      expect(json['subEvent']).to eq(
        [{
          '@type' => 'Event',
          '@id' => 'http://test.host/topics/ruby-rocks-9',
          'url' => 'http://test.host/topics/ruby-rocks-9',
          'name' => 'Ruby rocks',
          'description' => helper.markdown_to_text(event.topics.first.description),
          'startDate' => '2011-11-11T18:00:00+01:00',
          'endDate' => '2011-11-11T20:00:00+01:00',
          'location' => json['location'],
          'performer' => { '@type' => 'Person', '@id' => 'http://test.host/users/phoet-5', 'name' => 'Peter', 'url' => 'http://test.host/users/phoet-5' },
        }]
      )
    end
  end

  describe '#json_ld_event_list' do
    it 'wraps events in an item list' do
      json = helper.json_ld_event_list([event])

      expect(json).to include('@context' => 'https://schema.org', '@type' => 'ItemList', 'numberOfItems' => 1)
      expect(json['itemListElement'].first).to include('@type' => 'ListItem', 'position' => 1)
      expect(json['itemListElement'].first['item']).to include('@type' => 'Event', 'name' => 'awesome ottawa')
      expect(json['itemListElement'].first['item']).not_to have_key('@context')
    end
  end
end

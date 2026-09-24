# frozen_string_literal: true

require 'spec_helper'

describe Rubyevents::Feed do
  subject(:feed) { described_class.new(whitelabel) }

  let(:whitelabel) { Whitelabel.find_label('hamburg') }

  describe '#series' do
    it 'identifies the series by its dasherised label' do
      expect(feed.series['id']).to eq('hamburg')
    end

    it 'names the series in English' do
      expect(feed.series['name']).to eq('Ruby Usergroup Hamburg')
    end

    it 'is always a monthly meetup' do
      expect(feed.series).to include('kind' => 'meetup', 'frequency' => 'monthly')
    end

    it 'maps the locale to an ISO-639 English name' do
      expect(feed.series['language']).to eq('German')
    end

    it 'exposes the country code and website' do
      expect(feed.series).to include(
        'default_country_code' => 'DE',
        'website' => 'https://hamburg.onruby.de'
      )
    end

    it 'expands the github org into a URL' do
      expect(feed.series['github']).to eq('https://github.com/rughh')
    end

    it 'uses string keys throughout, so to_yaml is valid' do
      expect(feed.series.keys).to all(be_a(String))
    end

    it 'omits fields the usergroup has not set' do
      allow(whitelabel).to receive_messages(bluesky: nil, github_org: nil)

      expect(feed.series.keys).not_to include('bsky', 'github')
    end

    it 'dasherises a label id containing an underscore' do
      tallinn = Whitelabel.find_label('tallinn_rug')

      expect(described_class.new(tallinn).series['id']).to eq('tallinn-rug')
    end
  end

  describe '#event' do
    it 'derives its id from the series' do
      expect(feed.event['id']).to eq('hamburg-meetup')
    end

    it 'is an ongoing meetup with no dates' do
      expect(feed.event).to include('kind' => 'meetup')
      expect(feed.event.keys).not_to include('start_date', 'end_date')
    end

    it 'renders the location as City, Country in English' do
      expect(feed.event['location']).to eq('Hamburg, Germany')
    end

    it 'carries an IANA time zone' do
      expect(feed.event['timezone']).to eq('Europe/Berlin')
    end

    it 'always sends coordinates, which the schema requires' do
      expect(feed.event['coordinates']).to eq(
        'latitude' => 53.56544,
        'longitude' => 9.95947
      )
    end

    it 'describes the group using its English meta description' do
      expect(feed.event['description']).to eq('Ruby / Rails Usergroup Hamburg')
    end

    it 'omits the description when the label falls back to the default' do
      allow(I18n).to receive(:tw).and_call_original
      allow(I18n).to receive(:tw).with('meta_desc', locale: :en)
                                 .and_return('Ruby / Rails Communities Germany')

      expect(feed.event.keys).not_to include('description')
    end

    it 'raises for a country code it cannot name' do
      allow(whitelabel).to receive(:country_code).and_return('ZZ')

      expect { feed.event }.to raise_error(KeyError)
    end

    it 'uses string keys throughout, so to_yaml is valid' do
      expect(feed.event.keys).to all(be_a(String))
    end
  end
end

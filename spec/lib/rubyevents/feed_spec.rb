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

  describe '#videos' do
    let(:user) { create(:user, name: 'Ada Lovelace') }

    def create_event(date:, name: 'September Meetup')
      create(:event, name:, date:, description: 'Talks: and drinks', user:)
    end

    it 'is empty when the usergroup has no events' do
      expect(feed.videos).to eq([])
    end

    it 'lists editions oldest first' do
      create_event(date: 2.months.ago, name: 'July Meetup')
      create_event(date: 1.month.ago, name: 'August Meetup')

      expect(feed.videos.map { |edition| edition['title'] }).to eq(['July Meetup', 'August Meetup'])
    end

    it 'derives the edition id from the primary key, not the name' do
      event = create_event(date: 1.month.ago)

      expect(feed.videos.first).to include(
        'id' => "hamburg-event-#{event.id}",
        'video_id' => "hamburg-event-#{event.id}"
      )
    end

    it 'formats the date as YYYY-MM-DD' do
      create_event(date: Time.zone.local(2026, 9, 9, 19, 0))

      expect(feed.videos.first['date']).to eq('2026-09-09')
    end

    it 'preserves a description containing colons through a YAML round-trip' do
      create_event(date: 1.month.ago)

      round_tripped = YAML.safe_load(feed.videos.to_yaml)

      expect(round_tripped.first['description']).to eq('Talks: and drinks')
    end

    it 'marks an edition without topics as not_recorded' do
      create_event(date: 1.month.ago)

      expect(feed.videos.first['video_provider']).to eq('not_recorded')
    end

    # Their SpeakersOrTalks validator requires exactly one of `talks` or
    # `speakers` on every entry, so an edition without topics still carries an
    # empty talks list rather than dropping the key.
    it 'always carries a talks key, even when the edition had no topics' do
      create_event(date: 1.month.ago)

      expect(feed.videos.first).to include('talks' => [])
    end

    # Psych escapes U+2028/U+2029 as \L and \P, which rubyevents' formatter
    # then un-escapes into a literal block scalar where they act as real line
    # breaks and produce unparseable YAML.
    it 'normalises unicode line separators out of descriptions' do
      create(:event, name: 'Separator Meetup', date: 1.month.ago,
                     description: "before\u2028after", user:)

      description = feed.videos.first['description']

      expect(description).to eq("before\nafter")
      expect(description).not_to match(/[\u2028\u2029]/)
    end

    it 'marks an edition with topics as a parent of children' do
      event = create_event(date: 1.month.ago)
      create(:topic, event:, user:, name: 'Kafka at scale')

      expect(feed.videos.first['video_provider']).to eq('children')
    end

    it 'maps topics to talks with speakers and primary-key ids' do
      event = create_event(date: 1.month.ago)
      topic = create(:topic, event:, user:, name: 'Kafka at scale')

      expect(feed.videos.first['talks'].first).to include(
        'id' => "hamburg-event-#{event.id}-topic-#{topic.id}",
        'title' => 'Kafka at scale',
        'speakers' => ['Ada Lovelace'],
        'event_name' => 'September Meetup',
        'video_provider' => 'not_recorded'
      )
    end

    # yerba re-emits speaker names as plain scalars, and a plain scalar cannot
    # begin with a YAML indicator. Anyone can sign up with such a display name,
    # so the feed has to cope rather than assume clean input.
    it 'falls back to the nickname when the name opens with a yaml indicator' do
      speaker = create(:user, name: '@shageman', nickname: 'shageman')
      event = create_event(date: 1.month.ago)
      create(:topic, event:, user: speaker)

      expect(feed.videos.first['talks'].first['speakers']).to eq(['shageman'])
    end

    it 'strips the indicator when the nickname opens with one too' do
      speaker = create(:user, name: '@odd', nickname: '@odder')
      event = create_event(date: 1.month.ago)
      create(:topic, event:, user: speaker)

      expect(feed.videos.first['talks'].first['speakers']).to eq(['odd'])
    end

    it 'guards every yaml indicator, not only the at sign' do
      names = ['#hash', '-dash', '[bracket', '&anchor', '*alias', '!bang']
      names.each_with_index do |name, i|
        speaker = create(:user, name:, nickname: "nick#{i}")
        event = create_event(date: (i + 1).months.ago, name: "Meetup #{i}")
        create(:topic, event:, user: speaker)
      end

      emitted = feed.videos.flat_map { |e| e['talks'].map { |t| t['speakers'] } }.flatten

      expect(emitted).to match_array(names.each_index.map { |i| "nick#{i}" })
    end

    it 'marks talks of a future edition as scheduled' do
      event = create_event(date: 1.month.from_now)
      create(:topic, event:, user:)

      expect(feed.videos.first['talks'].first['video_provider']).to eq('scheduled')
    end

    it 'includes the first material as the slides url' do
      event = create_event(date: 1.month.ago)
      topic = create(:topic, event:, user:)
      create(:material, event:, topic:, user:, url: 'https://slides.example.org/kafka')

      expect(feed.videos.first['talks'].first['slides_url']).to eq('https://slides.example.org/kafka')
    end

    it 'omits the slides url when the topic has no material' do
      event = create_event(date: 1.month.ago)
      create(:topic, event:, user:)

      expect(feed.videos.first['talks'].first.keys).not_to include('slides_url')
    end
  end

  describe '#speakers' do
    let(:user) do
      create(:user, name: 'Ada Lovelace', github: 'AdaLovelace', twitter: 'ada',
                    linkedin: 'https://www.linkedin.com/in/ada-lovelace/', url: 'https://ada.example.org')
    end

    def speak!(speaker = user)
      event = create(:event, date: 1.month.ago, user: speaker)
      create(:topic, event:, user: speaker)
    end

    it 'is empty when nobody has spoken' do
      expect(feed.speakers).to eq([])
    end

    it 'names and slugs each speaker' do
      speak!

      expect(feed.speakers.first).to include('name' => 'Ada Lovelace', 'slug' => 'ada-lovelace')
    end

    it 'uses the same safe name in the profile as in videos, so they link up' do
      speak!(create(:user, name: '@shageman', nickname: 'shageman', github: 'shageman'))

      profile = feed.speakers.find { |it| it['github'] == 'shageman' }

      expect(profile).to include('name' => 'shageman', 'slug' => 'shageman')
      expect(feed.videos.flat_map { |e| e['talks'].flat_map { |t| t['speakers'] } })
        .to include(profile['name'])
    end

    it 'downcases the github handle so it matches existing entries' do
      speak!

      expect(feed.speakers.first['github']).to eq('adalovelace')
    end

    it 'always sends a github key, which the schema requires' do
      speak!(create(:user, name: 'No Handle', github: nil))

      expect(feed.speakers.map { |it| it['name'] }).to include('No Handle')
      expect(feed.speakers.find { |it| it['name'] == 'No Handle' }).to include('github' => '')
    end

    it 'reduces a linkedin profile URL to the handle their schema expects' do
      speak!

      expect(feed.speakers.first['linkedin']).to eq('ada-lovelace')
    end

    it 'passes a bare linkedin handle through' do
      speak!(create(:user, name: 'Bare Linked', linkedin: 'barelinked'))

      expect(feed.speakers.find { |it| it['name'] == 'Bare Linked' }['linkedin']).to eq('barelinked')
    end

    it 'maps the profile url to website and keeps twitter bare' do
      speak!

      expect(feed.speakers.first).to include('website' => 'https://ada.example.org', 'twitter' => 'ada')
    end

    it 'lists a speaker once however many talks they gave' do
      speak!
      speak!

      expect(feed.speakers.count { |it| it['name'] == 'Ada Lovelace' }).to eq(1)
    end

    it 'ignores proposals that are not attached to an event' do
      create(:proposal, user: create(:user, name: 'Only Proposed'))

      expect(feed.speakers.map { |it| it['name'] }).not_to include('Only Proposed')
    end
  end
end

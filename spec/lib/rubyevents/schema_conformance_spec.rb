# frozen_string_literal: true

require 'spec_helper'
require 'json_schemer'

describe 'rubyevents schema conformance' do
  def schema_for(name)
    JSONSchemer.schema(Rails.root.join("spec/fixtures/rubyevents/#{name}_schema.json"))
  end

  Whitelabel.labels.select(&:enabled?).each do |whitelabel|
    context "for #{whitelabel.label_id}" do
      subject(:feed) { Rubyevents::Feed.new(whitelabel) }

      it 'produces a valid series document' do
        expect(schema_for('series').validate(feed.series).to_a).to eq([])
      end

      it 'produces a valid event document' do
        expect(schema_for('event').validate(feed.event).to_a).to eq([])
      end
    end
  end

  describe 'the videos document, with editions to serve' do
    subject(:feed) { Rubyevents::Feed.new(Whitelabel.label) }

    before do
      user = create(:user, name: 'Ada Lovelace')

      past = create(:event, name: 'August Meetup', date: 1.month.ago, user:)
      topic = create(:topic, event: past, user:, name: 'Kafka: at scale')
      create(:material, event: past, topic:, user:, url: 'https://slides.example.org/kafka')

      upcoming = create(:event, name: 'October Meetup', date: 1.month.from_now, user:)
      create(:topic, event: upcoming, user:)
    end

    # An empty array satisfies the videos schema, so this guard stops the
    # validation example below from passing on nothing at all.
    it 'has editions to validate' do
      expect(feed.videos.size).to eq(2)
    end

    it 'validates a past edition with talks and slides, and a future edition' do
      expect(schema_for('videos').validate(feed.videos).to_a).to eq([])
    end
  end
end

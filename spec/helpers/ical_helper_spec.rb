# frozen_string_literal: true

require 'spec_helper'

describe IcalHelper do
  let(:event) { build(:event, id: 123, name: 'awesome ottawa', date: '11.11.2011 19:00 UTC') }

  it 'creates a valid icalendar event' do
    helper.icalendar(event).to_s.tap do |it|
      expect(it).to match('BEGIN:VCALENDAR')
      expect(it).to match('http://test.host/events/awesome-ottawa-123')
      expect(it).to match('SUMMARY:awesome ottawa')
    end
  end

  it 'handles events with no location' do
    event.location = nil
    helper.icalendar(event).to_s.tap do |it|
      expect(it).to match('BEGIN:VCALENDAR')
    end
  end
end

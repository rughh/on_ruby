require 'spec_helper'

describe IcalHelper do
  let(:event) { build(:event, id: 123, name: 'awesome ottawa', date: '11.11.2011 19:00 +02:00') }

  it 'creates a valid icalendar event' do
    helper.icalendar(event).to_s.tap do |it|
      expect(it).to match('http://test.host/events/awesome-ottawa-123')
      expect(it).to match('SUMMARY:awesome ottawa')
      expect(it).to match('DTSTART:20111111T170000Z')
    end
  end

  it 'references the json-ld representation as structured data (RFC 9073)' do
    ical = helper.icalendar(event).to_s.gsub("\r\n ", '')

    expect(ical).to include(
      'STRUCTURED-DATA;FMTTYPE=application/ld+json;SCHEMA="https://schema.org/Event";VALUE=URI:http://test.host/events/awesome-ottawa-123.jsonld'
    )
  end

  it 'handles events with no location' do
    event.location = nil
    helper.icalendar(event).to_s.tap do |it|
      expect(it).to match('BEGIN:VCALENDAR')
    end
  end
end

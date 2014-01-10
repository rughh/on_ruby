require 'spec_helper'

describe IcalHelper do
  let(:event) { build(:event, id: 123, name: 'awesome ottawa', date: '11.11.2011 19:00 UTC') }

  it "creates a valid icalendar event" do
    helper.icalendar(event).to_s.tap do |it|
      expect(it).to match("BEGIN:VCALENDAR")
      expect(it).to match('http://test.host/events/123')
      expect(it).to match('SUMMARY:awesome ottawa')
    end
  end
end

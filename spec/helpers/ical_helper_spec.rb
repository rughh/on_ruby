require 'spec_helper'

describe IcalHelper do
  let(:event) { build(:event, id: 123, name: 'awesome ottawa', date: '11.11.2011 19:00 UTC') }

  it "creates a valid icalendar event" do
    helper.icalendar(event).to_s.tap do |it|
      it.should match("BEGIN:VCALENDAR")
      it.should match('http://test.host/events/123')
      it.should match('SUMMARY:awesome ottawa')
    end
  end
end

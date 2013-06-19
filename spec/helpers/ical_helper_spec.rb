require 'spec_helper'

describe IcalHelper do
  let(:event) { build(:event, id: 123, name: 'awesome ottawa', date: '11.11.2011 19:00 UTC') }

  it "creates a valid icalendar event" do
    helper.calendar(event).to_s.tap do |it|
      it.should match("BEGIN:VCALENDAR\r\nCALSCALE:GREGORIAN\r\nMETHOD:PUBLISH\r\nPRODID:iCalendar-Ruby\r\nVERSION:2.0\r\nBEGIN:VEVENT\r\nCOMMENT:iCal Event by On Ruby!")
      it.should match('http://test.host/events/123')
      it.should match('SUMMARY:awesome ottawa')
    end
  end
end

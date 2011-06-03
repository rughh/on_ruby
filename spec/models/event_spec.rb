require 'spec_helper'

describe Event do
  before(:each) do
    @event = Factory(:event)
  end
  
  it "should provide end_date" do
    @event.end_date.should > @event.date
  end
  
  it "should create ical" do
    @event.to_ical('path').gsub!(/DTSTAMP:\w+/, 'DTSTAMP:20101212T172636').should == <<-ICAL
BEGIN:VCALENDAR\r
CALSCALE:GREGORIAN\r
METHOD:PUBLISH\r
PRODID:iCalendar-Ruby\r
VERSION:2.0\r
BEGIN:VEVENT\r
COMMENT:iCal Event by Hamburg on Ruby!\r
CREATED:114730\r
DESCRIPTION:MyText\r
DTEND:20101206T134730\r
DTSTAMP:20101212T172636\r
DTSTART:20101206T114730\r
CLASS:PUBLIC\r
LAST-MODIFIED:114730\r
LOCATION:Blau Mobilfunk GmbH\r
SEQUENCE:0\r
SUMMARY:Weihnachtstreffen\r
UID:path\r
URL:path\r
END:VEVENT\r
END:VCALENDAR\r
    ICAL
  end
  
  it "should create a proper twitter-message" do
    @event.twitter_message('URL').should eql('Weihnachtstreffen am 06. Dezember, 11:47 Uhr - URL')
  end
  
  it "should find a current event" do
    @event.date = Time.now
    @event.save!
    Event.current.should_not be(nil)
  end
  
  it "should find preview_events" do
    10.times{|i| Factory(:event, :name => "Event #{i}", :date => (Time.now + i.weeks)) }
    Event.preview_events.map(&:name).should == ['Event 9', 'Event 8']
  end
  
end

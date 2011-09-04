require 'spec_helper'

describe Event do
  
  let(:event) { Factory(:event) }
  
  it "should provide end_date" do
    event.end_date.should > event.date
  end
  
  it "should create ical" do
    event.to_ical('path').gsub!(/DTSTAMP:\w+/, 'DTSTAMP:20101212T172636').should == <<-ICAL
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
    event.twitter_message('URL').should eql('Weihnachtstreffen am 06. Dezember, 11:47 Uhr - URL')
  end
  
  it "should find a current event" do
    event.date = Time.now
    event.save!
    Event.current.first.should_not be(event)
  end
  
  it "should duplicate the event" do
    Factory(:event)
    expect { Event.duplicate! }.to change(Event, :count).by(1)
  end
  
  it "should find latest events" do
    10.times{|i| Factory(:event, :name => "Event #{i}", :date => (Time.now - i.weeks)) }
    Event.latest.map(&:name).should == ["Event 1", "Event 2", "Event 3", "Event 4", "Event 5"]
  end
  
  describe "#next_event_date" do
    it "should always be in the future on wednesday" do
      Event.next_event_date.should be_wednesday
      Event.next_event_date.should be > Date.today
    end
    
    it "should find the second wednesday" do
      Event.second_wednesday(Time.new(2011, 9, 1, 0, 0, 0)).should eql(Time.new(2011, 9, 14, 0, 0, 0))
    end
  end
end

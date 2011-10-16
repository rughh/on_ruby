require 'spec_helper'

describe Event do

  let(:event) { Factory.build(:event) }

  it "should provide end_date" do
    event.end_date.should > event.date
  end

  it "should create a proper twitter-message" do
    event.twitter_message('http://some.url').should eql('Weihnachtstreffen am 06. Dezember, 11:47 Uhr - http://some.url')
  end

  it "should find a current event" do
    event.date = Time.now
    event.save!
    Event.current.first.should_not be(event)
  end

  context "#duplicate!" do
    before do
      Factory(:event, date: Time.utc(2011, 9, 14, 19, 0, 0))
    end

    it "should duplicate the event" do
      expect { Event.duplicate! }.to change(Event, :count).by(1)
    end
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

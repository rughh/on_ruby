require 'spec_helper'

describe Event do

  let(:event) { build(:event) }

  it "should provide end_date" do
    event.end_date.should > event.date
  end

  it "should find a current event" do
    event.date = Time.now
    event.save!
    Event.current.first.should_not be(event)
  end

  context "#duplicate!" do
    before do
      create(:event, date: Time.utc(2011, 9, 14, 19, 0, 0))
    end

    it "should duplicate the event" do
      expect { Event.duplicate! }.to change(Event, :count).by(1)
    end
  end

  it "should find latest events" do
    10.times{|i| create(:event, :name => "Event #{i}", :date => (Time.now - i.weeks)) }
    Event.latest.map(&:name).should == ["Event 1", "Event 2", "Event 3", "Event 4", "Event 5", "Event 6", "Event 7", "Event 8", "Event 9"]
  end
end

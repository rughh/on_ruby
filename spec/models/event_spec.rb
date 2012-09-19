require 'spec_helper'

describe Event do

  let(:event) { create(:event) }

  it "should provide end_date" do
    event.end_date.should > event.date
  end

  context "validation" do
    it "should be valid" do
      event.should be_valid
    end

    it "should validate uniqueness" do
      build(:event, name: event.name).should have(1).errors_on(:name)
      Whitelabel.with_label(Whitelabel.labels.last) do
        build(:event, name: event.name).should have(0).errors_on(:name)
      end
    end
  end

  context "current event" do
    it "should find a current event" do
      event_next = create(:event, date: 2.days.from_now)
      event_after_next = create(:event, date: 4.days.from_now)
      Event.current.first.should_not be(event_next)
    end
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

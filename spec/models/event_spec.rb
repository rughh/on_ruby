require 'spec_helper'

describe Event do
  let(:event) { create(:event) }

  it "should provide end_date" do
    expect(event.end_date).to be > event.date
  end

  context "validation" do
    it "should be valid" do
      expect(event).to be_valid
    end

    it "should validate uniqueness" do
      expect(build(:event, name: event.name)).to have(1).errors_on(:name)
      Whitelabel.with_label(Whitelabel.labels.last) do
        expect(build(:event, name: event.name)).to have(0).errors_on(:name)
      end
    end
  end

  context "current event" do
    it "should find a current event" do
      event_next = create(:event, date: 2.days.from_now)
      expect(Event.current.first).to eql(event_next)
    end
  end

  context "#duplicate!" do
    before do
      create(:event, date: Time.utc(2011, 9, 14, 19, 0, 0))
    end

    it "should duplicate the event" do
      expect {
        Event.duplicate!
      }.to change(Event, :count).by(1)
    end
  end

  context "#closed?" do
    let(:event) { create(:event_with_participants) }

    it "calculates closed" do
      expect(event).to have(3).participants
      expect(event).to_not be_closed

      event.limit = 3
      expect(event).to be_closed
    end
  end

  context "stats" do
    it "has empty stats" do
      stats = {
        participants: 0,
        topics: 0,
      }
      expect(Event.stats).to eql(stats)
    end

    it "calculates stats" do
      create(:full_event)
      stats = {
        participants: 4,
        topics: 1,
      }
      expect(Event.stats(size: 1)).to eql(stats)
    end
  end

  it "should find latest events" do
    10.times{|i| create(:event, :name => "Event #{i}", :date => (Time.now - i.weeks)) }
    expect(Event.latest.map(&:name)).to eql(["Event 1", "Event 2", "Event 3", "Event 4", "Event 5", "Event 6", "Event 7", "Event 8", "Event 9"])
  end
end

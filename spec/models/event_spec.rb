require 'spec_helper'

describe Event do
  let(:event) { create(:event) }

  it 'provides end_date' do
    expect(event.end_date).to be > event.date
  end

  context 'validation' do
    it 'is valid' do
      expect(event).to be_valid
    end

    it 'validates uniqueness' do
      expect(build(:event, name: event.name)).to have(1).errors_on(:name)
      Whitelabel.with_label(Whitelabel.labels.last) do
        expect(build(:event, name: event.name)).to have(0).errors_on(:name)
      end
    end
  end

  context 'current event' do
    it 'finds a current event' do
      event_next = create(:event, date: 2.days.from_now)
      expect(Event.current.first).to eql(event_next)
      event_next.update(date: 5.months.from_now)
      expect(Event.current.first).to eql(event_next)
    end
  end

  describe '#duplicate!' do
    before do
      create(:event, date: Time.utc(2011, 9, 14, 19, 0, 0))
    end

    it 'duplicates the event' do
      expect do
        Event.duplicate!
      end.to change(Event, :count).by(1)
    end
  end

  describe '#closed?' do
    let(:event) { create(:event_with_participants) }

    it 'calculates closed' do
      expect(event).to have(3).participants
      expect(event).not_to be_closed

      event.limit = 3
      expect(event).to be_closed
    end
  end

  context 'stats' do
    it 'has empty stats' do
      stats = {
        participants: 0,
        topics: 0,
      }
      expect(Event.stats).to eql(stats)
    end

    it 'calculates stats' do
      create(:full_event)
      stats = {
        participants: 1,
        topics: 0,
      }
      expect(Event.stats(size: 4)).to eql(stats)
    end
  end

  context 'slug' do
    it 'finds by id' do
      event = create(:event, id: 999)

      expect(Event.from_slug('999')).to eql(event)
      expect(Event.from_slug('-999')).to eql(event)
    end

    it 'finds by slug' do
      event = create(:event, id: 999)

      expect(Event.from_slug('bla-999')).to eql(event)
    end

    it 'finds by name' do
      event = create(:event, name: 'Hamburg Meetup Soandso')

      expect(Event.from_slug('hamburg-meetup-soandso')).to eql(event)
    end

    it 'raises an error like find' do
      expect { Event.from_slug('murks') }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  it 'finds latest events' do
    10.times { |i| create(:event, name: "Event #{i}", date: (Time.now - i.weeks)) }
    expect(Event.latest.map(&:name)).to eql(['Event 1', 'Event 2', 'Event 3', 'Event 4', 'Event 5', 'Event 6', 'Event 7', 'Event 8', 'Event 9'])
  end
end

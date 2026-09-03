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
      expect(errors_on(build(:event, name: event.name), :name).size).to eq(1)
      Whitelabel.with_label(Whitelabel.labels.last) do
        expect(errors_on(build(:event, name: event.name), :name).size).to eq(0)
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

    it 'includes events happening later today within the configured time zone' do
      travel_to Time.zone.local(2026, 8, 31, 10, 0, 0) do
        event_today = create(:event, date: Time.zone.local(2026, 8, 31, 19, 0, 0))
        expect(Event.current.first).to eql(event_today)
      end
    end

    it 'includes events happening earlier today within the configured time zone' do
      travel_to Time.zone.local(2026, 8, 31, 20, 0, 0) do
        event_earlier_today = create(:event, date: Time.zone.local(2026, 8, 31, 9, 0, 0))
        expect(Event.current.first).to eql(event_earlier_today)
      end
    end

    it 'includes an event later tonight even in the small hours' do
      travel_to Time.zone.local(2026, 8, 31, 1, 30, 0) do
        event_tonight = create(:event, date: Time.zone.local(2026, 8, 31, 19, 0, 0))
        expect(Event.current.first).to eql(event_tonight)
      end
    end

    # Just after local midnight the calendar date in Europe/Berlin is already
    # one day ahead of UTC. The old `Date.today.to_time` boundary was computed
    # from the process's system zone, so on a UTC host yesterday's event leaked
    # into `.current`; `Date.current.beginning_of_day` keeps it out. (On a host
    # already in Europe/Berlin the two boundaries coincide.)
    it 'excludes yesterday\'s event right after midnight in the configured time zone' do
      travel_to Time.zone.local(2026, 9, 1, 0, 20, 0) do
        create(:event, date: Time.zone.local(2026, 8, 31, 19, 0, 0))
        todays_event = create(:event, date: Time.zone.local(2026, 9, 1, 19, 0, 0))

        expect(Event.current.first).to eql(todays_event)
      end
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

    context 'when usergroup has no recurring date configured' do
      before { allow(Whitelabel.label).to receive(:recurring).and_return(nil) }

      it 'does not raise a NoMethodError' do
        expect { Event.duplicate! }.not_to raise_error
      end

      it 'infers the next date from the latest event' do
        Event.duplicate!
        expect(Event.last.date).to be_wednesday
      end
    end
  end

  describe '.infer_next_date_from' do
    it 'returns the same weekday and time one month later' do
      date = Time.utc(2025, 3, 12, 19, 0) # second Wednesday of March, 19:00

      result = travel_to(Time.zone.local(2025, 4, 1, 1, 4, 44)) { Event.infer_next_date_from(date) }

      expect(result).to be_wednesday
      expect(result.month).to eq(4)
      expect(result.hour).to eq(19)
      expect(result.min).to eq(0)
    end

    it 'returns the next future occurrence even if the date is several months in the past' do
      date   = 4.months.ago.change(day: 1).next_occurring(:thursday).advance(weeks: 2) # 3rd Thursday, 4 months ago
      result = Event.infer_next_date_from(date)
      expect(result).to be_thursday
      expect(result).to be > Time.now
    end
  end

  describe '#closed?' do
    let(:event) { create(:event_with_participants) }

    it 'calculates closed' do
      expect(event.participants.size).to eq(3)
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

  describe '.latest' do
    it 'finds latest events' do
      10.times { |i| create(:event, name: "Event #{i}", date: (Time.now - i.weeks)) }
      expect(Event.latest.map(&:name)).to eql(['Event 1', 'Event 2', 'Event 3', 'Event 4', 'Event 5', 'Event 6', 'Event 7', 'Event 8', 'Event 9'])
    end

    it 'does not include events happening earlier today in the configured time zone' do
      travel_to Time.zone.local(2026, 8, 31, 20, 0, 0) do
        create(:event, name: 'Today Event', date: Time.zone.local(2026, 8, 31, 9, 0, 0))
        past_event = create(:event, name: 'Yesterday Event', date: Time.zone.local(2026, 8, 30, 19, 0, 0))

        expect(Event.latest).to contain_exactly(past_event)
      end
    end

    # Counterpart to the `.current` spec: right after local midnight yesterday's
    # event must show up in `.latest`, which the old system-zone boundary got
    # wrong on a UTC host.
    it 'includes yesterday\'s event right after midnight in the configured time zone' do
      travel_to Time.zone.local(2026, 9, 1, 0, 20, 0) do
        past_event = create(:event, name: 'Yesterday Event', date: Time.zone.local(2026, 8, 31, 19, 0, 0))
        create(:event, name: 'Tonight Event', date: Time.zone.local(2026, 9, 1, 19, 0, 0))

        expect(Event.latest).to contain_exactly(past_event)
      end
    end
  end
end

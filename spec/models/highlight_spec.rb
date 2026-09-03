require 'spec_helper'

describe Highlight do
  let(:highlight) { build(:highlight) }
  let(:active_highlight) { build(:highlight, start_at: Date.tomorrow, end_at: 2.days.since) }

  it 'is valid' do
    expect(highlight).to be_valid
  end

  it 'is active' do
    expect(active_highlight).not_to be_disabled
  end

  it 'disables a highlight' do
    active_highlight.disable!
    expect(active_highlight).to be_disabled
  end

  context 'finder' do
    before do
      active_highlight.save!
    end

    it 'finds the active highlight' do
      expect(Highlight.active.size).to eq(1)
    end

    it 'ignores highlights whose end_at is in the past' do
      create(:highlight, start_at: 3.days.ago, end_at: 1.day.ago)

      expect(Highlight.active).to contain_exactly(active_highlight)
    end

    it 'returns the one starting soonest when several are active' do
      later = create(:highlight, start_at: 10.days.from_now, end_at: 20.days.from_now)

      expect(Highlight.active.first).to eq(active_highlight)
      expect(later).to be_present
    end
  end

  context 'disabled?' do
    it 'is disabled once end_at has passed' do
      expect(build(:highlight, start_at: 2.days.ago, end_at: 1.day.ago)).to be_disabled
    end

    it 'is not disabled while end_at is still in the future' do
      expect(build(:highlight, start_at: 1.day.ago, end_at: 1.day.from_now)).not_to be_disabled
    end
  end
end

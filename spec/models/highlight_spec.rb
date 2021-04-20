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
      expect(Highlight.active).to have(1).elements
    end
  end
end

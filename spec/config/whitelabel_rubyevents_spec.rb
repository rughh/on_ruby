# frozen_string_literal: true

require 'spec_helper'

describe 'whitelabel data required by the rubyevents feed' do
  subject(:labels) { Whitelabel.labels.select(&:enabled?) }

  it 'has enabled labels to serve' do
    expect(labels).not_to be_empty
  end

  it 'gives every enabled label an ISO 3166 alpha-2 country code' do
    missing = labels.reject { |label| label.country_code.to_s.match?(/\A[A-Z]{2}\z/) }

    expect(missing.map(&:label_id)).to eq([])
  end

  it 'gives every enabled label a valid IANA time zone' do
    invalid = labels.reject { |label| TZInfo::Timezone.all_identifiers.include?(label.default_time_zone) }

    expect(invalid.map(&:label_id)).to eq([])
  end
end

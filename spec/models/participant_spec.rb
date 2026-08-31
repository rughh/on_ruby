require 'spec_helper'

describe Participant do
  it 'validates presence' do
    expect(errors_on(subject, :event).size).to eq(2)
    expect(errors_on(subject, :user).size).to eq(2)
  end
end

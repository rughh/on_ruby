require 'spec_helper'

describe Job do
  subject { Job.new }

  it 'validates presence' do
    expect(errors_on(subject, :name).size).to eq(1)
    expect(errors_on(subject, :url).size).to eq(1)
    expect(errors_on(subject, :location).size).to eq(2)
  end
end

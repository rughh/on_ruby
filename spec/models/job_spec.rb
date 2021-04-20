require 'spec_helper'

describe Job do
  subject { Job.new }

  it 'validates presence' do
    expect(subject).to have(1).errors_on(:name)
    expect(subject).to have(1).errors_on(:url)
    expect(subject).to have(2).errors_on(:location)
  end
end

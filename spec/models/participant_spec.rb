require 'spec_helper'

describe Participant do
  it 'validates presence' do
    expect(subject).to have(2).errors_on(:event)
    expect(subject).to have(2).errors_on(:user)
  end
end

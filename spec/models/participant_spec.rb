require 'spec_helper'

describe Participant do

  let(:participant) { Participant.new }

  it "should validate presence" do
    participant.should have(1).errors_on(:event)
    participant.should have(1).errors_on(:user)
  end

end

require 'spec_helper'

describe Participant do

  subject { Participant.new }

  it "should validate presence" do
    should have(1).errors_on(:event)
    should have(1).errors_on(:user)
  end

end

require 'spec_helper'

describe Participant do

  it { should validate_presence_of(:user, :event) }

end

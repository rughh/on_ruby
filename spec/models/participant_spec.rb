require 'spec_helper'

include SpecHelper

describe Participant do

  it { should validate_presence_of(:user, :event) }

end

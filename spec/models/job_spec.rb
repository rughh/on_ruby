require 'spec_helper'

describe Job do

  subject { Job.new }

  it "should validate presence" do
    should have(1).errors_on(:name)
    should have(1).errors_on(:url)
    should have(1).errors_on(:location)
  end

end

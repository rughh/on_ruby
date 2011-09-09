require 'spec_helper'

describe Location do

  let(:location) { Factory(:location) }

  context "finder" do
    it "should find distinct cometogethers" do
      3.times.each { |n| Factory(:event, location: location) }
      Location.cometogether.should have(1).things
    end
  end
end

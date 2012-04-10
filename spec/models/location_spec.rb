require 'spec_helper'

describe Location do

  let(:location) { FactoryGirl.create(:location) }

  context "finder" do
    it "should find distinct cometogethers" do
      5.times.each { |n| FactoryGirl.create(:event, location: location) }
      Location.cometogether.all.should have(1).things
    end
  end
end

require 'spec_helper'

describe Location do

  before(:each) do
    @location       = FactoryGirl.create(:location)
    @other_location = FactoryGirl.create(:location, label: "cologne")
  end

  context "finder" do
    it "should find users within the default scope" do
      hamburg_locations = Location.all
      hamburg_locations.should have(1).elements
      hamburg_locations.first.should eql(@location)

      Location.unscoped.all.size.should be(2)
    end

    it "should find distinct cometogethers" do
      5.times.each { |n| FactoryGirl.create(:event, location: @location) }
      Location.cometogether.all.should have(1).things
    end
  end
end

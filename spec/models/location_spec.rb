require 'spec_helper'

describe Location do

  before(:each) do
    @location       = create(:location)
    @other_location = create(:location, label: "cologne")
  end

  context "finder" do
    it "should find users within the default scope" do
      hamburg_locations = Location.all
      hamburg_locations.should have(1).elements
      hamburg_locations.first.should eql(@location)

      Location.unscoped.all.size.should be(2)
    end
  end

  describe "#full_address" do
    it 'should return a full address string with street, house_number, zip, city and internationalized country name' do
      @location.full_address.should eq('Schanzenstr. 85, 20357 Hamburg, Deutschland')
    end
  end
end

require 'spec_helper'

describe Location do

  before(:each) do
    @location       = create(:location, name: 'Test-Location', street: "Schanzenstr.", house_number: "85", zip: "20357", city: "Hamburg")
    @other_location = create(:location, label: "cologne")
  end

  context "validation" do
    let(:very_long_url) { "https://www.google.com/maps/preview#!q=Paradestra%C3%9Fe&data=!1m4!1m3!1d11961!2d13.4128013!3d52.4771952!4m15!2m14!1m13!1s0x47a84fe027a5216b%3A0xc46f55a5cdb71fe7!3m8!1m3!1d11961!2d13.4128013!3d52.4771952!3m2!1i1680!2i945!4f13.1!4m2!3d52.4781867!4d13.3858645" }

    it "is valid" do
      expect(build(:location)).to be_valid
    end

    it "validates length of url" do
      expect(build(:location, url: very_long_url)).to have(1).errors_on(:url)
    end
  end

  context "finder" do
    it "should find users within the default scope" do
      hamburg_locations = Location.all
      expect(hamburg_locations).to have(1).elements
      expect(hamburg_locations.first).to eql(@location)
      expect(Location.unscoped.size).to be(2)
    end
  end

  context "#geo_coder_address" do
    it 'should return a full address string with street, house_number, zip, city and internationalized country name' do
      expect(@location.geo_coder_address).to eq('Schanzenstr. 85, 20357 Hamburg, Deutschland')
    end
  end

  context "#geocoding" do
    it 'should geocode once a location is saved' do
      Location.all.each do |locn|
        expect(locn.lat).to_not be_nil
        expect(locn.long).to_not be_nil
      end
    end

    it 'should geocode with expected data once a location is saved' do
      expect(@location.lat).to be(Geocoder.coordinates(@location.geo_coder_address)[0])
      expect(@location.long).to be(Geocoder.coordinates(@location.geo_coder_address)[1])
    end
  end

end

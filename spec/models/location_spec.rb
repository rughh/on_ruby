require 'spec_helper'

describe Location do
  before do
    @location         = create(:location, name: 'Test-Location', street: 'Schanzenstr.', house_number: '85', zip: '20357', city: 'Hamburg')
    @other_location   = create(:location, label: 'cologne')
    @es_location      = create(:location, label: 'madridrb')
    @virtual_location = create(:virtual_location, label: 'madridrb')
  end

  context 'validation' do
    let(:very_long_url) { 'https://www.google.com/maps/preview#!q=Paradestra%C3%9Fe&data=!1m4!1m3!1d11961!2d13.4128013!3d52.4771952!4m15!2m14!1m13!1s0x47a84fe027a5216b%3A0xc46f55a5cdb71fe7!3m8!1m3!1d11961!2d13.4128013!3d52.4771952!3m2!1i1680!2i945!4f13.1!4m2!3d52.4781867!4d13.3858645' }

    it 'is valid' do
      expect(build(:location)).to be_valid
    end

    it 'validates length of url' do
      expect(build(:location, url: very_long_url)).to have(1).errors_on(:url)
    end

    it 'accepts virtual locations without geo info' do
      expect(build(:virtual_location)).to be_valid
    end
  end

  context 'finder' do
    it 'finds users within the default scope' do
      hamburg_locations = Location.all
      expect(hamburg_locations).to have(1).elements
      expect(hamburg_locations.first).to eql(@location)
      expect(Location.unscoped.size).to be(4)
    end
  end

  describe '#geo_coder_address' do
    it 'returns a full address string with street, house_number, zip, city and internationalized country name' do
      expect(@location.geo_coder_address).to eq('Schanzenstr. 85, 20357 Hamburg, Deutschland')
    end

    it 'fetches country names by label' do
      expect(@es_location.country).to eq('Espania')
    end
  end

  describe "#calendar_event_address" do
    it "returns the full address if all fields are present" do
      expect(@location.calendar_event_address).to eq(@location.address)
    end

    it "returns the location name if not all fields are present" do
      expect(@virtual_location.calendar_event_address).to eq(@virtual_location.name)
    end
  end

  describe '#geocoding' do
    it 'geocodes once a location is saved' do
      Location.all.find_each do |locn|
        expect(locn.lat).not_to be_nil
        expect(locn.long).not_to be_nil
      end
    end

    it 'does not geocode virtual locations' do
      expect(@virtual_location.lat).to be_nil
      expect(@virtual_location.long).to be_nil
    end

    it 'geocodes with expected data once a location is saved' do
      expect(@location.lat).to be(Geocoder.coordinates(@location.geo_coder_address)[0])
      expect(@location.long).to be(Geocoder.coordinates(@location.geo_coder_address)[1])
    end
  end
end

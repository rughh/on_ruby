require 'spec_helper'

describe GeoJob, job: true do
  it 'geocodes with expected data once a location is saved' do
    @location = create(:location, street: "Schanzenstr.", house_number: "85", zip: "20357", city: "Hamburg", lat: nil, long: nil)

    expect(@location.reload.lat).to be(Geocoder.coordinates(@location.full_address)[0])
    expect(@location.reload.long).to be(Geocoder.coordinates(@location.full_address)[1])
  end
end

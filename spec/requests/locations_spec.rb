require 'spec_helper'

describe 'Locations', type: :request do
  describe 'GET /locations' do
    it 'renders the index' do
      create(:location)

      get locations_path

      expect(response).to be_ok
    end
  end

  describe 'GET /locations/:id' do
    it 'renders the location' do
      location = create(:location)

      get location_path(location)

      expect(response).to be_ok
      expect(response.body).to include(location.name)
    end
  end
end

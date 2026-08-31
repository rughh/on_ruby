require 'spec_helper'

describe 'Admin: location management', type: :request do
  before { sign_in_via_github(admin: true) }

  let(:address) do
    { street: 'Eifflerstraße', house_number: '43', city: 'Hamburg', zip: '22769' }
  end

  describe 'POST /admin/locations' do
    it 'creates a standard location' do
      expect do
        post '/admin/locations', params: {
          location: { name: 'Betahaus', url: 'https://betahaus.de', **address },
        }
      end.to change(Location, :count).by(1)

      location = Location.order(:created_at).last
      expect(location).to have_attributes(name: 'Betahaus', label: 'hamburg')
      expect(location).not_to be_company
      expect(location).not_to be_virtual
      expect(response).to redirect_to(admin_location_path(location))
    end

    it 'creates a location flagged as a company' do
      post '/admin/locations', params: {
        location: { name: 'Acme Inc', url: 'https://acme.example', company: '1', **address },
      }

      expect(Location.order(:created_at).last).to be_company
    end

    it 'creates a virtual location without an address' do
      params = { location: { name: 'Remote Space', url: 'https://meet.example', virtual: '1' } }

      expect { post '/admin/locations', params: params }.to change(Location, :count).by(1)
      expect(Location.order(:created_at).last).to be_virtual
    end
  end

  describe 'PATCH /admin/locations/:id' do
    it 'updates the location' do
      location = create(:location)

      patch admin_location_path(location), params: { location: { name: 'Renamed Venue' } }

      expect(location.reload.name).to eq('Renamed Venue')
      expect(response).to redirect_to(admin_location_path(location))
    end
  end

  describe 'DELETE /admin/locations/:id' do
    it 'deletes the location' do
      location = create(:location)

      expect { delete admin_location_path(location) }.to change(Location, :count).by(-1)
      expect(response).to redirect_to(admin_locations_path)
    end
  end
end

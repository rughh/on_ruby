require 'spec_helper'

# Smoke coverage for the dashboards that exist only under `/super_admin`
# (no `/admin` equivalent). CRUD behaviour is exercised in detail by
# super_admin/events_spec.rb and the Admin:: request specs.
describe 'Super admin: super-admin-only dashboards', type: :request do
  before { sign_in_via_github(admin: true, super_admin: true) }

  it 'lists authorizations' do
    create(:authorization)

    get '/super_admin/authorizations'

    expect(response).to have_http_status(:ok)
  end

  it 'lists likes' do
    create(:like)

    get '/super_admin/likes'

    expect(response).to have_http_status(:ok)
  end

  it 'lists participants' do
    create(:participant)

    get '/super_admin/participants'

    expect(response).to have_http_status(:ok)
  end

  it 'lists materials' do
    create(:material)

    get '/super_admin/materials'

    expect(response).to have_http_status(:ok)
  end

  it 'lists highlights' do
    create(:highlight)

    get '/super_admin/highlights'

    expect(response).to have_http_status(:ok)
  end
end

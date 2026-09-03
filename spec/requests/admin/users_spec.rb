require 'spec_helper'

describe 'Admin: users dashboard', type: :request do
  before { sign_in_via_github(admin: true) }

  it 'lists only users of the current usergroup' do
    here = Whitelabel.with_label(Whitelabel.labels.first) { create(:event_with_participants) }
    elsewhere = Whitelabel.with_label(Whitelabel.labels.last) { create(:event_with_participants) }

    get '/admin/users'

    expect(response).to have_http_status(:ok)
    expect(response.body).to include(here.participants.first.user.nickname)
    expect(response.body).not_to include(elsewhere.participants.first.user.nickname)
  end
end

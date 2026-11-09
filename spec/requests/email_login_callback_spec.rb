require 'spec_helper'

# The happy path lives in spec/system/email_authentication_spec.rb.
describe 'GET /auth/email/callback', type: :request do
  it 'does not sign in with an expired or forged token', :aggregate_failures do
    expired = EmailAuthToken.generate('someone@example.org', expiration: -1)
    forged = EmailAuthToken.generate('someone@example.org', secret: 'not the app secret')

    [expired, forged].each do |token|
      get '/auth/email/callback', params: { token: }

      expect(response.location).to include('/auth/failure')
    end
    expect(User.count).to eq(0)
  end
end

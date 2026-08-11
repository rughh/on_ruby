require 'spec_helper'

describe 'Google OAuth2 login', type: :request do
  let(:google_uid) { '1' }

  before do
    stub_request(:get, 'https://www.googleapis.com/oauth2/v3/userinfo').to_return(
      status: 200,
      headers: { 'Content-Type' => 'application/json' },
      body: {
        sub: google_uid,
        name: 'Test User',
        given_name: 'Test',
        family_name: 'User',
        email: 'test-google-user@example.com',
        email_verified: true,
        picture: 'https://example.com/avatar.png',
      }.to_json
    )
  end

  it 'signs the user in through the real omniauth-google-oauth2 and jwt gems' do
    post '/auth/google_oauth2'
    stub_google_token_exchange(client_id: request.env['omniauth.strategy'].options.client_id)
    get '/auth/google_oauth2/callback', params: { code: 'fake-code', state: session['omniauth.state'] }

    expect(response).to redirect_to(root_path)
    expect(User.find_by(email: 'test-google-user@example.com')).to be_present
  end

  # client_id is read from the strategy's own options (set on the request env), not
  # ENV, so it matches whatever the id_token's aud claim gets checked against.
  def stub_google_token_exchange(client_id:)
    stub_request(:post, 'https://oauth2.googleapis.com/token').to_return(
      status: 200,
      headers: { 'Content-Type' => 'application/json' },
      body: {
        access_token: 'fake-access-token',
        token_type: 'Bearer',
        expires_in: 3600,
        id_token: google_id_token(client_id),
      }.to_json
    )

    # the credentials block fetches the token's scope via Google's tokeninfo endpoint
    stub_request(:post, 'https://www.googleapis.com/oauth2/v3/tokeninfo').to_return(
      status: 200,
      headers: { 'Content-Type' => 'application/json' },
      body: { aud: client_id, scope: 'openid email profile', expires_in: 3600 }.to_json
    )
  end

  def google_id_token(client_id)
    JWT.encode(
      {
        iss: 'https://accounts.google.com',
        aud: client_id,
        sub: google_uid,
        iat: 1_700_000_000,
        nbf: 1_700_000_000,
        exp: 4_102_444_800, # 2100-01-01 - far enough out to never expire in CI
      },
      'unused-signing-key',
      'HS256'
    )
  end
end

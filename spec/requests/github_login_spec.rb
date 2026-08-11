require 'spec_helper'

describe 'GitHub login', type: :request do
  let(:github_uid) { 1 }

  # GitHub creds are resolved per-request from a hostname-derived ENV var (see
  # config/initializers/omniauth.rb), so stubbing them per-example is safe.
  around do |example|
    original_key = ENV['OMNIAUTH_GITHUB_ONRUBY_TEST_KEY']
    original_secret = ENV['OMNIAUTH_GITHUB_ONRUBY_TEST_SECRET']
    ENV['OMNIAUTH_GITHUB_ONRUBY_TEST_KEY'] = 'test_github_client_id'
    ENV['OMNIAUTH_GITHUB_ONRUBY_TEST_SECRET'] = 'test_github_client_secret'

    example.run

    ENV['OMNIAUTH_GITHUB_ONRUBY_TEST_KEY'] = original_key
    ENV['OMNIAUTH_GITHUB_ONRUBY_TEST_SECRET'] = original_secret
  end

  before do
    stub_request(:post, 'https://github.com/login/oauth/access_token').to_return(
      status: 200,
      headers: { 'Content-Type' => 'application/json' },
      body: {
        access_token: 'fake-access-token',
        token_type: 'bearer',
        scope: '',
      }.to_json
    )

    stub_request(:get, 'https://api.github.com/user').to_return(
      status: 200,
      headers: { 'Content-Type' => 'application/json' },
      body: {
        id: github_uid,
        login: 'octocat',
        name: 'Test User',
        email: 'octocat@example.com',
        avatar_url: 'https://example.com/avatar.png',
        html_url: 'https://github.com/octocat',
        blog: 'https://example.com',
        bio: 'A test account used for specs.',
        location: 'Nowhere',
      }.to_json
    )
  end

  it 'signs the user in through the real omniauth-github and omniauth-oauth2 gems' do
    post '/auth/github'
    state = session['omniauth.state']

    get '/auth/github/callback', params: { code: 'fake-code', state: state }

    expect(response).to redirect_to(root_path)
    expect(User.find_by(email: 'octocat@example.com')).to be_present
  end
end

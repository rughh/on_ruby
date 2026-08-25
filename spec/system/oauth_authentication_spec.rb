require 'spec_helper'

RSpec.describe 'OAuth authentication', type: :system do
  before do
    driven_by :rack_test
    OmniAuth.config.test_mode = true
  end

  after do
    OmniAuth.config.mock_auth.clear
    OmniAuth.config.test_mode = false
  end

  it 'logs in through GitHub with a mocked OAuth response' do
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(GITHUB_AUTH_HASH)

    visit login_path
    within('#nav') { click_button I18n.t('login.github_login') }

    expect(page).to have_current_path('/')
    expect(page).to have_link(I18n.t('login.profile'))
    expect(page).to have_content(
      I18n.t('flash.logged_in', name: GITHUB_AUTH_HASH['info']['name'])
    )

    user = User.find_by!(email: GITHUB_AUTH_HASH['info']['email'])
    expect(user.authorizations.find_by(provider: 'github', uid: GITHUB_AUTH_HASH['uid'])).to be_present
  end

  it 'logs in through Google with a mocked OAuth response' do
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(GOOGLE_AUTH_HASH)

    visit login_path
    within('#nav') { click_button I18n.t('login.google_oauth2_login') }

    expect(page).to have_current_path('/')
    expect(page).to have_link(I18n.t('login.profile'))
    expect(page).to have_content(
      I18n.t('flash.logged_in', name: GOOGLE_AUTH_HASH['info']['name'])
    )

    user = User.find_by!(email: GOOGLE_AUTH_HASH['info']['email'])
    expect(user.authorizations.find_by(provider: 'google_oauth2', uid: GOOGLE_AUTH_HASH['uid'])).to be_present
  end
end

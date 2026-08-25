require 'spec_helper'

RSpec.describe 'Event registration', type: :system do
  let!(:event) do
    create(
      :event,
      name: 'Ruby System Spec Event',
      date: 1.day.from_now,
      description: 'An event for the RSVP system spec.'
    )
  end

  before do
    driven_by :rack_test
    Capybara.app_host = 'http://hamburg.onruby.de'
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(GITHUB_AUTH_HASH)
  end

  after do
    OmniAuth.config.mock_auth.clear
    OmniAuth.config.test_mode = false
  end

  it 'allows an authenticated user to RSVP to an upcoming event' do
    visit login_path
    within('#nav') { click_button I18n.t('login.github_login') }
    expect(page).to have_link(I18n.t('login.profile'))

    visit event_path(event)
    expect(page).to have_button(I18n.t('show.attend'))

    click_button I18n.t('show.attend')

    expect(page).to have_current_path(event_path(event))
    expect(page).to have_content(I18n.t('flash.now_participating'))
    expect(page).to have_button(I18n.t('show.not_attend'))
    expect(event.reload.participants.where(user: User.find_by!(email: GITHUB_AUTH_HASH['info']['email'])).count).to eq(1)

    click_button I18n.t('show.not_attend')

    expect(page).to have_current_path(event_path(event))
    expect(event.reload.participants.count).to eq(0)
  end
end

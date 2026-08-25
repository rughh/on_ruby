require 'spec_helper'
require 'uri'

RSpec.describe 'Profile completion', type: :system do
  include ActiveJob::TestHelper

  let(:email) { 'profile-user@example.org' }
  let!(:event) { create(:event, date: 1.day.from_now) }

  before do
    driven_by :rack_test
    ActionMailer::Base.deliveries.clear
    clear_enqueued_jobs
  end

  after do
    ActionMailer::Base.deliveries.clear
    clear_enqueued_jobs
  end

  it 'requires an email user to complete their name before attending an event' do
    sign_in_with_email
    user = User.find_by!(email:)

    expect(page).to have_current_path(edit_user_path(user))
    expect(page).to have_field('user_name')

    fill_in 'user_name', with: ''
    within('form.simple_form') { click_button }

    expect(page).to have_current_path(edit_user_path(user))
    expect(page).to have_field('user_name')
    expect(user.reload.name).to eq(User::EMPTY_NAME)

    fill_in 'user_name', with: 'Email User'
    within('form.simple_form') { click_button }

    expect(user.reload.name).to eq('Email User')

    visit event_path(event)

    expect(page).to have_current_path(event_path(event))
    expect(page).to have_link(I18n.t('show.attend'))
  end

  private

  def sign_in_with_email
    visit '/sessions/email'
    fill_in 'email', with: email

    perform_enqueued_jobs do
      click_button I18n.t('email_auth.submit')
    end

    callback_url = ActionMailer::Base.deliveries.last.body.decoded[%r{https?://\S+}]
    visit URI.parse(callback_url).request_uri
  end
end

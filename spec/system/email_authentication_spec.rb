require 'spec_helper'
require 'uri'

RSpec.describe 'Email authentication', type: :system do
  include ActiveJob::TestHelper

  let(:email) { 'new-user@example.org' }

  before do
    driven_by :rack_test
    ActionMailer::Base.deliveries.clear
    clear_enqueued_jobs
  end

  after do
    ActionMailer::Base.deliveries.clear
    clear_enqueued_jobs
  end

  it 'registers and logs in a user through the email link' do
    visit '/sessions/email'
    fill_in 'email', with: "  #{email.upcase}  "

    perform_enqueued_jobs do
      click_button I18n.t('email_auth.submit')
    end

    expect(page).to have_content(
      I18n.t('email_auth.email_sent', email: email.downcase)
    )

    mail = ActionMailer::Base.deliveries.last
    expect(mail.to).to eq([email.downcase])

    callback_url = mail.body.decoded[%r{https?://\S+}]
    expect(callback_url).to be_present

    visit URI.parse(callback_url).request_uri
    user = User.find_by!(email: email.downcase)

    expect(page).to have_current_path(edit_user_path(user))
    expect(page).to have_content(I18n.t('flash.logged_in', name: ''))
    expect(page).to have_link(I18n.t('login.profile'))

    expect(user.authorizations.find_by(provider: 'email')).to be_present
  end
end

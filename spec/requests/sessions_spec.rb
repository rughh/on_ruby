require 'spec_helper'

# The OAuth happy paths run through the real strategy gems in
# spec/requests/github_login_spec.rb and google_oauth2_login_spec.rb; this file
# covers the remaining SessionsController behaviour.
describe 'Sessions', type: :request do
  describe 'GET /auth/:provider/callback' do
    before { mock_github_omniauth }

    it 'signs in and generates a nickname when the one from the provider is taken' do
      create(:user, nickname: GITHUB_AUTH_HASH['info']['nickname'])

      expect { get '/auth/github/callback' }.to change(User, :count).by(1)
      expect(response).to redirect_to(root_path)
      expect(User.order(:created_at).last.nickname).not_to eq(GITHUB_AUTH_HASH['info']['nickname'])
    end
  end

  describe 'GET /auth/failure' do
    it 'redirects to the root with an alert' do
      get '/auth/failure'

      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).not_to be_nil
    end

    it 'does not report to Appsignal when there is no omniauth error' do
      expect(Appsignal).not_to receive(:report_error)

      get '/auth/failure'
    end

    it 'reports the underlying omniauth error to Appsignal when present' do
      error = StandardError.new('boom')
      expect(Appsignal).to receive(:report_error).with(error)

      get '/auth/failure', headers: { 'omniauth.error' => error }
    end
  end

  describe 'GET /auth/destroy_session' do
    it 'signs the user out' do
      login_as(create(:user))

      get destroy_session_path

      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).not_to be_nil
    end
  end

  describe 'POST /sessions/email_login' do
    it 'enqueues the login email and redirects' do
      expect { post '/sessions/email_login', params: { email: 'user@example.org' } }
        .to have_enqueued_job(ActionMailer::MailDeliveryJob)

      expect(response).to redirect_to(root_path)
    end

    it 'does not send an email when the param is missing' do
      expect { post '/sessions/email_login' }
        .not_to have_enqueued_job(ActionMailer::MailDeliveryJob)

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'does not send an email for a malformed address' do
      expect { post '/sessions/email_login', params: { email: 'user@org' } }
        .not_to have_enqueued_job(ActionMailer::MailDeliveryJob)

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end

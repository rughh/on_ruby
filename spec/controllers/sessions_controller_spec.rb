require 'spec_helper'

describe SessionsController do
  context 'GET :create' do
    before { request.env['omniauth.auth'] = GITHUB_AUTH_HASH }

    it 'renders the :index template' do
      get :create, params: { provider: :github }
      expect(controller.send(:signed_in?)).to be_truthy
      expect(response).to redirect_to(root_path)
    end

    it 'signs in a new user with a generated nickname when the nickname is already taken' do
      create(:user, nickname: 'phoet')

      expect { get :create, params: { provider: :github } }.to change(User, :count).by(1)
      expect(controller.send(:signed_in?)).to be_truthy
      expect(response).to redirect_to(root_path)
    end
  end

  context 'GET :failure' do
    it 'handles failure modes' do
      get :failure
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).not_to be_nil
    end
  end

  context 'GET :destroy' do
    it 'destroys a user session', :aggregate_failures do
      get :destroy
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).not_to be_nil
    end
  end

  context 'for email auth' do
    before do
      request.env['omniauth.auth'] = EMAIL_AUTH_HASH
      request.host = 'hamburg.onruby.de'
    end

    context 'POST :email_login' do
      it 'sends the email and redirect to index', :aggregate_failures do
        expect { post :email_login, params: { email: 'user@example.org' } }
          .to have_enqueued_job(ActionMailer::MailDeliveryJob)

        expect(response).to redirect_to(root_path)
      end

      it 'does not send the email if param missing', :aggregate_failures do
        expect { post :email_login }
          .not_to have_enqueued_job(ActionMailer::MailDeliveryJob)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not send the email looks bad', :aggregate_failures do
        expect { post :email_login, params: { email: 'user@org' } }
          .not_to have_enqueued_job(ActionMailer::MailDeliveryJob)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end

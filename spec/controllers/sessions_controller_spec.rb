require 'spec_helper'

describe SessionsController do
  context 'GET :create' do
    before { request.env['omniauth.auth'] = TWITTER_AUTH_HASH }

    it 'renders the :index template' do
      get :create, params: { provider: :twitter }
      expect(controller.send(:signed_in?)).to be_truthy
      expect(response).to redirect_to(root_path)
    end

    it 'rescues from duplicate nicknames' do
      create(:user, nickname: 'phoet')

      get :create, params: { provider: :twitter }
      expect(controller.send(:signed_in?)).to be_falsy
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to match('bereits vergeben')
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
          .to have_enqueued_job(ActionMailer::DeliveryJob)

        expect(response).to redirect_to(root_path)
      end

      it 'does not send the email if param missing', :aggregate_failures do
        expect { post :email_login }
          .not_to have_enqueued_job(ActionMailer::DeliveryJob)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not send the email looks bad', :aggregate_failures do
        expect { post :email_login, params: { email: 'user@org' } }
          .not_to have_enqueued_job(ActionMailer::DeliveryJob)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'GET :create' do
      it 'creates the user and redirects to edit', :aggregate_failures do
        get :create, params: { provider: :email }
        expect(controller.send(:signed_in?)).to be_truthy
        expect(response).to redirect_to(edit_user_path(User.last))
      end
    end
  end
end

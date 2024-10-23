require 'spec_helper'

describe UsersController do
  let(:user) { create(:user) }
  let(:user_with_events) { create(:organizer_user) }
  let(:user_with_participations) { create(:participant_user) }
  let(:data) { { id: user.to_param, user: { github: 'testo', linkedin: 'testyin', freelancer: true, available: true } } }
  let(:unallowed_data) { data.merge(user: { nickname: 'not_allowed_property' }) }

  context 'GET :show' do
    context 'unknown user' do
      render_views

      it 'rescues from not found' do
        get :show, params: { id: 'unknown' }
        expect(response).to be_not_found
      end
    end

    it 'shows the user when organized an event' do
      get :show, params: { id: user_with_events.id }
      expect(response).to be_ok
    end

    it 'shows the user participates an event' do
      get :show, params: { id: user_with_participations.id }
      expect(response).to be_ok
    end
  end

  context 'GET :edit' do
    it 'shows alert for wrong user' do
      get :edit, params: { id: user }
      expect(flash[:alert]).not_to be_nil
      expect(response).to redirect_to(root_path)
    end

    context 'if the user has an unfilled name' do
      render_views

      it 'clears the name input and sets it to error' do
        allow(@controller).to receive_messages(current_user: user)
        user.update(name: User::EMPTY_NAME)

        get :edit, params: { id: user }

        doc = Nokogiri::HTML(response.body)
        input = doc.at_css('.form-group.user_name.form-group-invalid input')
        expect(input).not_to be_nil
        expect(input[:value].to_s.strip).to eq('')
      end
    end
  end

  context 'GET :calendar' do
    it 'shows alert for wrong user' do
      get :calendar, params: { id: user_with_participations, format: :ics }
      expect(response.body).to match(/BEGIN:VCALENDAR/)
    end
  end

  context 'DELETE :destroy' do
    context 'removing' do
      let(:authorization) { create(:authorization) }
      let(:user) { authorization.user }
      let(:event) { create(:event) }

      it 'deletes a user and logout' do
        allow(@controller).to receive_messages(current_user: user)

        expect do
          expect do
            delete :destroy, params: { id: user.id }
          end.to change(User, :count).by(-1)
        end.to change(Authorization, :count).by(-1)
        expect(flash[:notice]).not_to be_nil
        expect(response).to redirect_to(destroy_session_path)
      end

      it 'does not delete an organizer' do
        allow(@controller).to receive_messages(current_user: event.user)
        expect do
          delete :destroy, params: { id: event.user.id }
        end.not_to change(User, :count)

        expect(flash[:alert]).not_to be_nil
        expect(response).to redirect_to(edit_user_path(event.user))
      end
    end
  end

  context 'PUT :update' do
    before { set_referer }

    it 'updates the github attribute of a user' do
      allow(controller).to receive_messages(current_user: user)

      put :update, params: data
      expect(response).to be_a_redirect

      expect(user.github).to eql('testo')
      expect(user.linkedin).to eql('testyin')
      expect(user.freelancer).to be_truthy
      expect(user.available).to be_truthy
    end

    it 'does not update injected properties' do
      allow(controller).to receive_messages(current_user: user)

      expect { put :update, params: unallowed_data }.not_to change(user, :nickname)
    end

    it 'updates nothing for wrong user' do
      put :update, params: data
      expect(flash[:alert]).not_to be_nil
      expect(response).to redirect_to(root_path)
    end
  end
end

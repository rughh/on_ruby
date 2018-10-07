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
    it 'should show alert for wrong user' do
      get :edit, params: { id: user }
      expect(flash[:alert]).to_not be_nil
      expect(response).to redirect_to(root_path)
    end
  end

  context 'GET :calendar' do
    it 'should show alert for wrong user' do
      get :calendar, params: { id: user_with_participations, format: :ics }
      expect(response.body).to match(/BEGIN:VCALENDAR/)
    end
  end

  context 'DELETE :destroy' do
    context 'removing' do
      let(:user) { create(:user, authorizations: [create(:authorization)]) }
      let(:event) { create(:event) }

      it 'should delete a user and logout' do
        allow(@controller).to receive_messages(current_user: user)

        expect {
          expect {
            delete :destroy, params: { id: user.id }
          }.to change(User, :count).by(-1)
        }.to change(Authorization, :count).by(-1)
        expect(flash[:notice]).to_not be_nil
        expect(response).to redirect_to(destroy_session_path)
      end

      it 'should not delete an organizer' do
        allow(@controller).to receive_messages(current_user: event.user)
        expect do
          delete :destroy, params: { id: event.user.id }
        end.to change(User, :count).by(0)

        expect(flash[:alert]).to_not be_nil
        expect(response).to redirect_to(edit_user_path(event.user))
      end
    end
  end

  context 'PUT :update' do
    before { set_referer }

    it 'should update the github attribute of a user' do
      allow(controller).to receive_messages(current_user: user)

      put :update, params: data
      expect(response).to be_a_redirect

      expect(user.github).to eql('testo')
      expect(user.linkedin).to eql('testyin')
      expect(user.freelancer).to be_truthy
      expect(user.available).to be_truthy
    end

    it 'should not update injected properties' do
      allow(controller).to receive_messages(current_user: user)

      put :update, params: data
      expect(user.nickname).to eql(user.nickname)
    end

    it 'should update nothing for wrong user' do
      put :update, params: data
      expect(flash[:alert]).to_not be_nil
      expect(response).to redirect_to(root_path)
    end
  end
end

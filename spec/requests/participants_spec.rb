require 'spec_helper'

describe 'Participants', type: :request do
  describe 'POST /events/:event_id/participants' do
    let(:event) { create(:event) }

    it 'redirects anonymous visitors to the login' do
      expect { post event_participants_path(event) }.not_to change(Participant, :count)

      expect(response).to redirect_to(login_path)
      expect(flash[:alert]).not_to be_nil
    end

    it 'adds the current user as a participant' do
      login_as(create(:user))

      expect { post event_participants_path(event) }.to change(Participant, :count).by(1)
      expect(response).to redirect_to(event_path(event))
      expect(flash[:notice]).not_to be_nil
    end

    it 'does not add a user who already participates' do
      user = login_as(create(:user))
      event.particpate(user)

      expect { post event_participants_path(event) }.not_to change(Participant, :count)
      expect(response).to redirect_to(event_path(event))
      expect(flash[:alert]).not_to be_nil
    end

    it 'does not add a participant to a closed event' do
      login_as(create(:user))
      closed = create(:closed_event)

      expect { post event_participants_path(closed) }.not_to change(Participant, :count)
      expect(response).to redirect_to(event_path(closed))
      expect(flash[:alert]).not_to be_nil
    end
  end

  describe 'DELETE /events/:event_id/participants/:id' do
    let!(:participant) { create(:participant) }

    it 'redirects anonymous visitors to the login' do
      expect { delete event_participant_path(participant.event, participant) }.not_to change(Participant, :count)

      expect(response).to redirect_to(login_path)
      expect(flash[:alert]).not_to be_nil
    end

    it 'removes the participant for its owner' do
      login_as(participant.user)

      expect { delete event_participant_path(participant.event, participant) }.to change(Participant, :count).by(-1)
      expect(response).to redirect_to(event_path(participant.event))
    end

    it 'does not remove the participant for a different user' do
      login_as(create(:user))

      expect { delete event_participant_path(participant.event, participant) }.not_to change(Participant, :count)
      expect(response).to redirect_to(event_path(participant.event))
      expect(flash[:alert]).not_to be_nil
    end
  end
end

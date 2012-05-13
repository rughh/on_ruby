require 'spec_helper'

describe ParticipantsController do

  before { set_subdomain }

  describe "DELETE :destroy" do
    before do
      @participant = FactoryGirl.create(:participant)
      @event = @participant.event
      @user = @participant.user
    end

    it "should delete a participant for current user" do
      @controller.stubs(:current_user => @user)
      expect { delete(:destroy, :id => @participant.id, :event_id => @event.id) }.to change(Participant, :count).by(-1)
      response.should redirect_to(@event)
    end

    it "should delete a participant for another user" do
      @controller.stubs(:current_user => FactoryGirl.create(:user))
      expect { delete(:destroy, :id => @participant.id, :event_id => @event.id) }.to change(Participant, :count).by(0)
      response.should redirect_to(@event)
    end
  end

end


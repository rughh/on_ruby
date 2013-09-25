require 'spec_helper'

describe ParticipantsController do
  let(:user) { create(:user) }
  let(:event) { create(:event) }

  context "POST :create" do
    before do
      controller.stub(current_user: user)
    end

    it "should add a user via json post" do
      expect { post :create, format: :json, event_id: event.id }.to change(Participant, :count).by(1)
      response.status.should be(201)
    end

    it "should add a prticipant for current user" do
      expect { post :create, event_id: event.id }.to change(Participant, :count).by(1)

      flash[:notice].should_not be_nil
      response.should redirect_to(event)
    end

    context "with an already participating user" do
      before do
        event.particpate(user)
      end

      it "should silently ignore the problem via json" do
        expect { post :create, format: :json, event_id: event.id }.to change(Participant, :count).by(0)

        response.status.should be(201)
      end

      it "should should alert a duplicate flash" do
        expect { post :create, event_id: event.id }.to change(Participant, :count).by(0)

        flash[:alert].should_not be_nil
        response.should redirect_to(event)
      end
    end
  end

  context "DELETE :destroy" do
    before do
      @participant = create(:participant)
      @event = @participant.event
      @user = @participant.user
    end

    it "should delete a participant for current user" do
      @controller.stub(:current_user => @user)
      expect { delete(:destroy, :id => @participant.id, :event_id => @event.id) }.to change(Participant, :count).by(-1)
      response.should redirect_to(@event)
    end

    it "should delete a participant for another user" do
      @controller.stub(:current_user => create(:user))
      expect { delete(:destroy, :id => @participant.id, :event_id => @event.id) }.to change(Participant, :count).by(0)
      response.should redirect_to(@event)
    end
  end
end

require 'spec_helper'

describe Admin::TopicsController do
  context "as admin" do

    before do
      allow(controller).to receive_messages(current_user: build(:admin_user))

      @proposal = create(:proposal)
    end

    context "GET :add_to_next_event" do
      it "attaches a proposal to the next event" do
        event = create(:event)
        get :add_to_next_event, id: @proposal

        expect(assigns[:topic].event).to eql(event)
        expect(assigns[:topic].event.users).to include(@proposal.user)
        expect(response).to be_a_redirect
      end

      it "does redirects back if there is no relevant event" do
        get :add_to_next_event, id: @proposal

        expect(response).to redirect_to(controller: "/admin/topics", action: :index)
      end
    end
  end
end

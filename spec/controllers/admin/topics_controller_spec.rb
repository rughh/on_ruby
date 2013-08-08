require 'spec_helper'

describe Admin::TopicsController do
  context "as admin" do
    before do
      controller.stubs(current_user: build(:admin_user))
    end

    context "GET :add_to_next_event" do
      it "attaches a proposal to the next event" do
        event     = create(:event)
        proposal  = create(:proposal)

        get :add_to_next_event, id: proposal

        expect(assigns[:topic].event).to eql(event)
        expect(assigns[:topic].event.users).to include(proposal.user)
        expect(response.status).to be(302)
      end
    end
  end
end

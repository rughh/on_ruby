require 'spec_helper'

describe EventsHelper do
  let(:event) { create(:event) }
  let(:participant) { create(:participant, user: event.user) }
  let(:participation_event) { create(:event, participants: [participant]) }

  context "signed_out user" do
    before(:each) do
      allow(helper).to receive_messages(signed_in?: false, current_user: nil)
    end

    context "#participation_link" do
      it "should have a login message attached" do
        expect(helper.participation_link(event)).to match("Bitte logge dich zuerst ein")
      end
    end
  end

  context "signed_in user" do
    before(:each) do
      allow(helper).to receive_messages(signed_in?: true, current_user: event.user)
    end

    context "#participation_link" do
      it "should render a paritcipate button" do
        expect(helper.participation_link(event)).to match("Teilnehmen")
      end

      it "disbales the button on closed events" do
        event = build(:closed_event)
        expect(helper.participation_link(event)).to match("data-disable")
      end

      it "should render a cancel button" do
        expect(helper.participation_link(participation_event)).to match("Absagen")
      end
    end
  end
end

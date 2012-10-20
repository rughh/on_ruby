# encoding: UTF-8
require 'spec_helper'

describe EventsHelper do
  let(:event) { create(:event) }
  let(:participant) { create(:participant, user: event.user) }
  let(:participation_event) { create(:event, participants: [participant]) }

  describe "signed_out user" do
    before(:each) do
      helper.stubs(signed_in?: false, current_user: nil)
    end

    describe "#participation_link" do
      it "should have a login message attached" do
        helper.participation_link(event).should match("Bitte logge dich zuerst ein")
      end
    end
  end

  describe "signed_in user" do
    before(:each) do
      helper.stubs(signed_in?: true, current_user: event.user)
    end

    describe "#participation_link" do
      it "should render a paritcipate button" do
        helper.participation_link(event).should match("Ich möchte teilnehmen")
      end

      it "should render a cancel button" do
        helper.participation_link(participation_event).should match("Nicht mehr teilnehmen")
      end
    end
  end
end

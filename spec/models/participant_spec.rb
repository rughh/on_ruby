require 'spec_helper'

describe Participant do

  subject { Participant.new }

  it "should validate presence" do
    should have(1).errors_on(:event)
    should have(1).errors_on(:user)
  end

  context "finder" do
    before(:each) do
      @event = FactoryGirl.create(:event)
      @user  = FactoryGirl.create(:user)
      @user.participants.create!(event: @event, user: @user)
    end
    it "should find users from a label" do
      Participant.label_users.should have(1).elements
    end
  end

end

require 'spec_helper'

describe User do
  context "validation" do

    let(:user) { FactoryGirl.build(:user) }
    let(:admin_user) { FactoryGirl.build(:user, :admin => true) }

    it "should allow names and nothing on github" do
      ["abc", "111bbb888_", nil, ""].each do |val|
        user.github = val
        user.should have(0).errors_on(:github)
      end
    end

    it "should not allow urls on github" do
      ["http://", "www.bla"].each do |val|
        user.github = val
        user.should have(1).errors_on(:github)
      end
    end

    it "should authorize phoet as admin" do
      admin_user.admin?.should be(true)
    end
  end

  context "finder" do
    let(:event) { FactoryGirl.create(:event) }
    let(:user) { FactoryGirl.create(:user) }
    let(:admin_user) { FactoryGirl.create(:user, :admin => true) }

    it "should participate?" do
      admin_user.participates?(event).should be(false)
      admin_user.participants.create!(:event => event, :user => admin_user)
      admin_user.participates?(event).should be(true)
    end

    it "should find the participation" do
      admin_user.participants.create!(:event => event, :user => admin_user)
      admin_user.participation(event).should_not be_nil
    end

    it "should select random users" do
      10.times {|i| FactoryGirl.create(:user, :nickname => "phoet#{i}")}
      users = User.random(5)
      users.size.should be(5)
      users.map(&:nickname).to_s.should_not be(User.random(5).map(&:nickname))
    end
  end
end

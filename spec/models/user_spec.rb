require 'spec_helper'

describe User do
  context "validation" do

    let(:user) { build(:user) }
    let(:admin_user) { build(:admin_user) }

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
    let(:event) { create(:event) }
    let(:user) { create(:user) }
    let(:admin_user) { create(:admin_user) }

    it "should find and transform usernames for semanticform" do
      %w(uschi klaus mauro).each { |name| create(:user, name: name, nickname: "nick_#{name}") }
      User.all_for_selections.should eql([
        ["klaus (nick_klaus)", 2],
        ["mauro (nick_mauro)", 3],
        ["uschi (nick_uschi)", 1]
      ])
    end

    it "should find peers" do
      3.times { create(:event_with_participants) }
      User.peers.should have(3).elements
    end

    it "should not find peers from different labels" do
      create(:event_with_participants)
      Whitelabel.with_label(Whitelabel.labels.last) do
        create(:event_with_participants)
      end
      User.peers.should have(1).elements
    end

    it "should participate?" do
      admin_user.participates?(event).should be(false)
      admin_user.participants.create!(event: event, user: admin_user)
      admin_user.participates?(event).should be(true)
    end

    it "should find the participation" do
      admin_user.participants.create!(event: event, user: admin_user)
      admin_user.participation(event).should_not be_nil
    end

    it "should select random users" do
      10.times {|i| create(:user, nickname: "phoet#{i}")}
      users = User.random(5)
      users.size.should be(5)
      users.map(&:nickname).to_s.should_not be(User.random(5).map(&:nickname))
    end
  end
end

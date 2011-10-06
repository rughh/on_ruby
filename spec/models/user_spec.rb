require 'spec_helper'

describe User do

  let(:event) { Factory(:event) }
  let(:admin_user) { Factory(:user, :admin => true) }

  it { should allow_values_for(:github, "abc", "111bbb888_", {allow_nil: true, allow_blank: true}) }
  it { should_not allow_values_for(:github, "http://", "www.bla") }

  it "should authorize phoet as admin" do
    admin_user.admin?.should be(true)
  end

  it "should participate?" do
    admin_user.participates?(event).should be(false)
    admin_user.participants.create!(:event_id => event.id, :user_id => admin_user.id)
    admin_user.participates?(event).should be(true)
  end

  it "should find the participation" do
    admin_user.participants.create!(:event_id => event.id, :user_id => admin_user.id)
    admin_user.participation(event).should_not be_nil
  end

  it "should select random users" do
    10.times {|i| Factory(:user, :nickname => "phoet#{i}")}
    users = User.random(5)
    users.size.should be(5)
    users.map(&:nickname).to_s.should_not be(User.random(5).map(&:nickname))
  end

end

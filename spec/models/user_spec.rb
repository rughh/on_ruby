require 'spec_helper'

include SpecHelper

describe User do
  
  before(:each) do
    @event = Factory(:event)
  end
  
  it "should authorize phoet as admin" do
    admin_user.admin?.should be(true)
  end
  
  it "should generate a twitter url" do
    admin_user.twurl.should == 'http://twitter.com/phoet'
  end
  
  it "should participate?" do
    admin_user.participates?(@event).should be(false)
    admin_user.participants.create!(:event_id => @event.id, :user_id => admin_user.id)
    admin_user.participates?(@event).should be(true)
  end
  
  it "should select random users" do
    10.times {|i| Factory(:user, :nickname => "phoet#{i}")}
    users = User.random(5)
    users.size.should be(5)
    users.map(&:nickname).to_s.should_not be(User.random(5).map(&:nickname))
  end
  
end

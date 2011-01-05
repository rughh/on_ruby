require 'spec_helper'

describe User do
  
  before(:each) do
    @admin = Factory(:user, :nickname => 'phoet')
    @event = Factory(:event)
  end
  
  it "should authorize phoet as admin" do
    @admin.admin?.should be(true)
  end
  
  it "should generate a twitter url" do
    @admin.twurl.should == 'http://twitter.com/phoet'
  end
  
  it "should participate?" do
    @admin.participates?(@event).should be(false)
    @admin.participants.create!(:event_id => @event.id, :user_id => @admin.id)
    @admin.participates?(@event).should be(true)
  end
  
  it "should find the participation" do
    @admin.participants.create!(:event_id => @event.id, :user_id => @admin.id)
    @admin.participation(@event).should_not be_nil
  end
  
  it "should select random users" do
    10.times {|i| Factory(:user, :nickname => "phoet#{i}")}
    users = User.random(5)
    users.size.should be(5)
    users.map(&:nickname).to_s.should_not be(User.random(5).map(&:nickname))
  end
  
end

require 'spec_helper'

describe Ability do
  
  before(:each) do
    @user = Factory(:user)
    @admin = Factory(:user, :nickname => 'phoet')
  end
  
  it "should authorize user for read" do
    Ability.new(@user).can?(:read, Event).should be(true)
    Ability.new(@user).can?(:manage, Event).should be(false)
  end

  it "should authorize admin for all" do
    Ability.new(@admin).can?(:manage, Event).should be(true)
  end
end

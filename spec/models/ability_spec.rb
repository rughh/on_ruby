require 'spec_helper'

include SpecHelper

describe Ability do
  
  before(:each) do
    @user = Factory(:user)
  end
  
  it "should authorize user for read" do
    Ability.new(@user).can?(:read, Event).should be(true)
    Ability.new(@user).can?(:manage, Event).should be(false)
  end

  it "should authorize admin for all" do
    Ability.new(admin_user).can?(:manage, Event).should be(true)
  end
end

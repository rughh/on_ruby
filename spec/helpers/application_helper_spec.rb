require "spec_helper"

describe ApplicationHelper do
  describe "#menu" do
    it "should return the HTML for the menu" do
      result = helper.menu
      result.scan('<li class="">').size.should == 5
    end
    
    it "should have an active menu item" do
      helper.stubs(:controller => OpenStruct.new(:controller_name => 'home', :action_name => 'info'))
      result = helper.menu
      result.scan('<li class="active">').size.should == 1
    end
  end
  
  describe "#login" do
    before(:each) do
      helper.stubs(:current_user => nil)
    end
    
    it "should return the HTML for the login-part" do
      result = helper.login
      result.should =~ /<div class="login">/
    end

    it "should show logout link for current_user" do
      result = helper.login
      result.should match(auth_path)
    end
    
    it "should show logout link for current_user" do
      user = Factory(:user)
      stubs(:current_user => user)
      result = helper.login
      result.should match(destroy_session_path)
    end
  end
end

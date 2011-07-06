require "spec_helper"

describe ApplicationHelper do
  
  before do
    @user = Factory(:user)
  end
  
  describe "#menu" do
    it "should return the HTML for the menu" do
      result = helper.menu
      result.scan('<li class="">').size.should == 5
    end
    
    it "should have an active menu item" do
      helper.stubs(:controller => OpenStruct.new(controller_name: 'home', action_name: 'info'))
      result = helper.menu
      result.scan('<li class="active">').size.should == 1
    end
  end
  
  describe "#login" do
    before do
      helper.stubs(current_user: nil)
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
      stubs(current_user: @user)
      result = helper.login
      result.should match('/auth/destroy_session') # destroy_session_path stopped working!
    end
  end
  
  describe "#link_to_github" do
    it "should generate the link" do
      helper.link_to_github(@user).should eql('<a href="http://github.com/giddiup">github.com/giddiup</a>')
    end
    
    it "should render nothing for no github" do
      @user.github = nil
      helper.link_to_github(@user).should be_nil
    end
  end
  
  describe "#link_to_twitter" do
    it "should generate the link" do
      nickname = @user.nickname
      helper.link_to_twitter(@user).should eql("<a href=\"http://twitter.com/#{nickname}\">@#{nickname}</a>")
    end
  end
  
end

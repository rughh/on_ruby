require "spec_helper"

describe ApplicationHelper do

  before(:each) do
    ActionController::TestRequest.any_instance.stubs(:fullpath => 'some_uri')
  end

  describe "#awesome_link_to" do
    it "should return the HTML for an awesome link" do
      result = helper.awesome_link_to :events, "http://example.com"
      result.should == '<li class=""><span></span><b><a href="http://example.com">Events</a></b></li>'
    end
    
    it "should have an active class for matching uri" do
      result = helper.awesome_link_to :events, "http://example.com/some_uri"
      result.should =~ /class="active"/
    end
  end

end

require "spec_helper"

describe ApplicationHelper do

  describe "#repo" do
    it "should have specs"
  end

  describe "#awesome_link_to" do
    it "should return the HTML for an awesome link" do
      result = helper.awesome_link_to :events, "http://example.com"
      result.should == '<li class=""><span></span><b><a href="http://example.com">Events</a></b></li>'
    end
  end

end

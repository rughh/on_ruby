require "spec_helper"

describe ApplicationHelper do

  describe "#repos" do
    it "should catch all exceptions" do
      Faraday.stub(:get).and_raise(RuntimeError)
      lambda { helper.repos('nick') }.should_not raise_error
    end

    it "should return an empty array on error" do
      Faraday.stub(:get).and_raise(RuntimeError)
      helper.repos('nick').should eql([])
    end
  end

  describe "#awesome_link_to" do
    it "should return the HTML for an awesome link" do
      result = helper.awesome_link_to :events, "http://example.com"
      result.should == '<li class=""><span></span><b><a href="http://example.com">Events</a></b></li>'
    end
  end

end

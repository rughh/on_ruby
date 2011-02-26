require 'spec_helper'

describe UsersHelper do
  describe "#repos" do
    it "should catch all exceptions" do
      Faraday.stubs(:get).raises(RuntimeError)
      lambda { helper.repos('nick') }.should_not raise_error
    end

    it "should return an empty array on error" do
      Faraday.stubs(:get).raises(RuntimeError)
      helper.repos('nick').should eql([])
    end
  end
end

require 'spec_helper'

describe WishHelper do
  describe "wish description" do
    before do
      @wish = Factory(:wish)
    end
    
    it "should render a list of stars" do
      output = helper.wish_description @wish
      output.scan('<a href').should have(6).things
    end
  end
end

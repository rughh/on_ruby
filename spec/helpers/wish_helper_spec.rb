# encoding: utf-8
require 'spec_helper'

describe WishHelper do
  
  describe "wish description" do
    before do
      @wish = Factory(:wish)
    end
    
    it "should render a list of stars" do
      helper.stubs(signed_in?: true)
      output = helper.stars @wish
      output.scan('<a href').should have(5).things
    end
  end
end

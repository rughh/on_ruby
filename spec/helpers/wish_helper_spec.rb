# encoding: utf-8
require 'spec_helper'

describe WishHelper do
  
  describe "activity label" do
    it "should give the right label for key" do
      label = helper.activity_type_label_method.call(Wish::ACTIVITY_WISH)
      label.should eql('Ich wünsche mir')
    end
  end
  
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

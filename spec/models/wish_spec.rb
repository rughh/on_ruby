require 'spec_helper'

describe Wish do
  before do
    @wish = Factory(:wish)
    @vote = Factory.build(:vote, :wish => nil)
  end
  
  context "with votes" do
    it "should calculate stars" do
      @wish.stars.should eql 0
      @wish.votes << @vote
      @wish.stars.should eql 5
      @wish.votes << Factory.build(:vote, :wish => nil, :count => 0)
      @wish.stars.should eql 2
    end
    
    it "should indicate already_voted?" do
      @wish.votes << @vote
      @wish.already_voted?(@vote.user).should be_true
    end
    
  end
  
end

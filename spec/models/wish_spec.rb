require 'spec_helper'

describe Wish do

  let(:wish) { Factory(:wish) }
  let(:vote) { Factory.build(:vote, :wish => nil) }

  it "should generate a nice twitter message" do
    message = Factory.build(:wish).twitter_message('http://bitly.url')
    message.length.should be < 140
    message.should match "Neues Thema von @uschi"
    message.should match "'The xing mobile website: touch.xing.com' http://bitly.url"
  end

  it "should create a topic from a wish" do
    Factory(:event)
    expect do
      wish.copy_to_topic!
      wish.done.should be(true)
    end.to change(Topic, :count).by(1)
  end

  context "with votes" do
    it "should calculate stars" do
      wish.stars.should eql 0.0
      wish.votes << vote
      wish.stars.should eql 5.0
      wish.votes << Factory.build(:vote, :wish => nil, :count => 0)
      wish.stars.should eql 2.5
    end

    it "should indicate already_voted?" do
      wish.votes << vote
      wish.already_voted?(vote.user).should be_true
    end
  end

end

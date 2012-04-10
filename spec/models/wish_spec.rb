require 'spec_helper'

describe Wish do

  let(:wish) { FactoryGirl.create(:wish) }
  let(:vote) { FactoryGirl.build(:vote, :wish => nil) }

  context "validation" do
    it "should be valid" do
      wish.should be_valid
    end

    it "should validate uniqueness" do
      FactoryGirl.build(:wish, name: wish.name).should have(1).errors_on(:name)
    end

    it "should validate presence" do
      Wish.new.tap do |it|
        it.should have(1).errors_on(:name)
        it.should have(1).errors_on(:description)
        it.should have(1).errors_on(:user)
      end
    end
  end

  it "should generate a nice twitter message" do
    FactoryGirl.build(:wish).twitter_message('http://some.url').tap do |it|
      it.length.should be < 140
      it.should match "Neues Thema von @uschi"
      it.should match "'The xing mobile website: touch.xing.com"
      it.should match "' http://some.url"
    end
  end

  it "should create a topic from a wish" do
    FactoryGirl.create(:event)
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
      wish.votes << FactoryGirl.build(:vote, :wish => nil, :count => 0)
      wish.stars.should eql 2.5
    end

    it "should indicate already_voted?" do
      wish.votes << vote
      wish.already_voted?(vote.user).should be_true
    end
  end
end

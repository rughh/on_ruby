# encoding: utf-8

require "spec_helper"

describe ApplicationHelper do

  let(:user) { FactoryGirl.build(:user) }

  describe "#link_to_github" do
    it "should generate the link" do
      helper.link_to_github(user).should eql('<a href="http://github.com/giddiup">giddiup</a>')
    end

    it "should render nothing for no github" do
      user.github = nil
      helper.link_to_github(user).should be_nil
    end
  end

  describe "#link_to_twitter" do
    it "should generate the link" do
      nickname = user.nickname
      helper.link_to_twitter(user).should eql("<a href=\"http://twitter.com/#{nickname}\">@#{nickname}</a>")
    end
  end

  describe "#twitter_update_url" do
    it "should generate a proper url" do
      url = 'http://twitter.com/home?status=h%C3%BC%C3%BCllloooo%20http://uschi.de'
      helper.twitter_update_url('hüüllloooo http://uschi.de').should eql(url)
    end
  end
end

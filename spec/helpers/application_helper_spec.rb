# encoding: utf-8

require "spec_helper"

describe ApplicationHelper do

  let(:user) { build(:user) }

  describe "#page_title" do
    it "should generate a page_title" do
      helper.page_title.should eql("Ruby Usergroup Hamburg - Hamburg on Ruby - Heimathafen der Hamburger Ruby Community - Ruby / Rails Usergroup Hamburg")
    end

    it "should have a page_title for default label" do
      Whitelabel.label = nil
      helper.page_title.should eql("Wir on Ruby - Ruby Communities Deutschland - Ruby Communities Deutschland")
    end
  end

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

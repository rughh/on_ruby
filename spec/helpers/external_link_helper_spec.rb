# encoding: utf-8
require "spec_helper"

describe ExternalLinkHelper do
  let(:user) { build(:user) }

  context "#link_to_github" do
    it "should generate the link" do
      user = build(:user, github: "giddiup")
      helper.link_to_github(user).should eql('<a href="http://github.com/giddiup" title="giddiup">giddiup</a>')
    end

    it "should render nothing for no github" do
      user.github = nil
      helper.link_to_github(user).should be_nil
    end
  end

  context "#link_to_twitter" do
    it "should generate the link" do
      user = build(:user, twitter: "klaus")
      helper.link_to_twitter(user).should eql('@<a href="http://twitter.com/klaus" title="klaus">klaus</a>')
    end
  end

  context "#twitter_update_url" do
    let(:topic) { create(:topic, name: "bla") }
    let(:event) { create(:event, name: "Weihnachtstreffen", date: "2010-12-06 11:47:30") }

    it "should generate a proper url for topics" do
      topic.user.name = "Uschi"

      url = helper.twitter_update_url(topic)
      url.should match(Regexp.escape("http://twitter.com/home?status=Neues%20Thema%20von%20@Uschi"))
      url.should match(Regexp.escape("http://test.host/topics/bla"))
    end

    it "should generate a proper url for events" do
      url = helper.twitter_update_url(event)
      url.should match(Regexp.escape("http://twitter.com/home?status=Weihnachtstreffen"))
      url.should match(Regexp.escape("am%2006.%20Dezember,%2011:47%20Uhr"))
      url.should match(Regexp.escape("http://test.host/events/weihnachtstreffen"))
    end
  end
end

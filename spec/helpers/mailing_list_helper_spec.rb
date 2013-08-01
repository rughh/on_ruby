require 'spec_helper'

describe MailingListHelper do
  context "the feed is available" do
    let(:entry) { stub(:title => 'A nice title', :url => 'http://some.url/a_nice_title') }
    let(:feed) { stub(:entries => [entry]) }

    it "should return the entries for the feed" do
      Feedzirra::Feed.stubs(:fetch_and_parse).returns(feed)

      helper.mailing_list_entries.should == feed.entries
    end
  end

  context "the feed was not available or not set" do
    it "should return a empty array" do
      helper.mailing_list_entries.should == []
    end
  end
end

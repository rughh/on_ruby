require 'feedzirra'

module MailingListHelper
  def mailing_list_entries(count = 15)
    feed_url = Whitelabel[:mailing_list_feed_url]
    if feed = Feedzirra::Feed.fetch_and_parse(feed_url)
      feed.entries[0..count-1]
    else
      []
    end
  end
end

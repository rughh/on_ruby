stubs = Faraday::Adapter::Test::Stubs.new do |stub|
  stub.get('/forum/feed/rubyonrails-ug-germany/topics/rss.xml?num=15') do |env|
    [ 200, {}, File.read("./spec/support/data/mailinglist_rss_feed.xml") ]
  end
end

Faraday.default_adapter = :test, stubs
module ExternalLinkHelper
  def wheelmap_badge(location, klass: 'wheelmap-status')
    return unless location.wheelmap_id.present?

    url   =  "https://wheelmap.org/nodes/#{location.wheelmap_id}"
    image = image_tag "https://img.shields.io/wheelmap/a/#{location.wheelmap_id}.svg", class: klass

    link_to image, url
  end

  def link_to_twitter(thing, params = { clung: false }, &block)
    nick = thing.respond_to?(:twitter) ? thing.twitter : thing
    url = "https://twitter.com/#{nick}"
    if block_given?
      link_to url, title: nick, &block
    else
      link = "@#{link_to(nick, url, title: nick)}"
      raw params[:clung] ? "(#{link})" : link
    end
  end

  def link_to_github(user, &block)
    return unless user.github
    url = "https://github.com/#{user.github}"
    title = user.github
    if block_given?
      link_to url, title: title, &block
    else
      link_to(user.github, url, title: title)
    end
  end

  def link_to_linkedin(user, &block)
    return unless user.linkedin
    url = "https://www.linkedin.com/in/#{user.linkedin}"
    title = user.linkedin
    if block_given?
      link_to url, title: title, &block
    else
      link_to(user.linkedin, url, title: title)
    end
  end

  def mailing_list_url
    group = Whitelabel[:google_group] || 'rubyonrails-ug-germany'
    "https://groups.google.com/group/#{group}"
  end

  FeedEntry = Struct.new(:title, :url)

  def mailing_list_entries(count = 15)
    url = mailing_list_feed_url(count)
    response = load_feed(url)
    response = Feedjira::Feed.parse(response.body)
    if response.respond_to?(:entries)
      response.entries.first(count).map { |entry| FeedEntry.new(entry.title.force_encoding('UTF-8'), entry.url.force_encoding('UTF-8'))}
    else
      []
    end
  rescue
    Rails.logger.warn "error fetching feed from #{url}: #{$!}"
    []
  end

  def load_feed(url, loader: Faraday)
    unless Rails.env.production?
      loader = Struct.new(:body) do
        def self.get(args)
          new(File.read("./spec/support/data/mailinglist_rss_feed.xml"))
        end
      end
    end
    loader.get(url)
  end

  def mailing_list_feed_url(count)
    group_name = Whitelabel[:google_group] || 'rubyonrails-ug-germany'
    "https://groups.google.com/forum/feed/#{group_name}/topics/rss.xml?num=#{count}"
  end

  def twitter_update_url(model)
    case model
    when Event
      options = { name: model.name, date: l(model.date, locale: I18n.locale, format: :short), url: event_url(model) }
    when Topic
      options = { username: model.user.name, name: model.name.truncate(50), url: topic_url(model) }
    end
    text = t("#{model.class.to_s.downcase}.twitter_message", options)
    "https://twitter.com/home?status=#{URI.encode(text)}"
  end

  def likes
    content_tag :span, class: 'likes' do
      javascript_include_tag("//apis.google.com/js/plusone.js", "//platform.twitter.com/widgets.js", async: true) +
      raw(%(
        <g:plusone size="medium"></g:plusone>
        <a href="https://twitter.com/share"
           class="twitter-share-button"
           data-url="#{url_for(only_path: false)}"
           data-count="horizontal"
           data-via="#{Whitelabel[:twitter]}"
           data-lang="#{I18n.locale.downcase}">Tweet</a>
      ))
    end
  end

  def ribbon(type)
    types = {
      github:                 ['Fork me on GitHub!',  'https://github.com/phoet/on_ruby'],
      senor_developer:        ['Señor Developer!',    'https://senordevelopershop.spreadshirt.de'],
      rgsoc:                  ['SUMMER OF CODE',      'https://railsgirlssummerofcode.org/campaign/'],
      patreon:                ['Become a patron',     'https://www.patreon.com/on_ruby'],
    }
    text, url = types[type]
    content_tag :div, id: "#{type}_ribbon", class: 'ribbon_wrap' do
      link_to url, id: type, title: text do
        content_tag :span, text
      end
    end
  end

  def slackin_js
    return if Whitelabel[:slackin_url].blank?

    javascript_include_tag Whitelabel[:slackin_url], async: true, defer: true
  end
end

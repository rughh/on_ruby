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

  def github_url(path = '')
    "https://github.com/#{Whitelabel[:github_org]}/#{Whitelabel[:github_repo]}/#{path}"
  end

  def github_issue_url(id)
    "#{github_url('issues')}/#{id}"
  end

  def github_new_issue_url
    if Whitelabel[:github_issue_template].present?
      "#{github_url('issues/new')}?template=#{Whitelabel[:github_issue_template]}"
    else
      github_url('issues/new')
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

  def github(event)
    return unless event.github_issue?

    content_tag :span, class: 'likes' do
      raw(
        %(
          <svg height="20" viewBox="0 0 16 16" version="1.1" width="20" style="margin-bottom: -6px"><path fill-rule="evenodd" d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27.68 0 1.36.09 2 .27 1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.013 8.013 0 0 0 16 8c0-4.42-3.58-8-8-8z"></path></svg>
        )
      ) +
      link_to('Github Planning Issue', github_issue_url(event.github_issue), target: '_blank')
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

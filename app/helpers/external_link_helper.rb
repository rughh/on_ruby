# frozen_string_literal: true

module ExternalLinkHelper
  def wheelmap_badge(location, klass: 'wheelmap-status')
    return if location.wheelmap_id.blank?

    url   = "https://wheelmap.org/nodes/#{location.wheelmap_id}"
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
      link_to url, title:, &block
    else
      link_to(user.github, url, title:)
    end
  end

  def link_to_linkedin(user, &block)
    return unless user.linkedin

    url = "https://www.linkedin.com/in/#{user.linkedin}"
    title = user.linkedin
    if block_given?
      link_to url, title:, &block
    else
      link_to(user.linkedin, url, title:)
    end
  end

  def mailing_list_url
    group = Whitelabel[:google_group] || 'rubyonrails-ug-germany'
    "https://groups.google.com/group/#{group}"
  end

  def load_feed(url, loader: Faraday)
    unless Rails.env.production?
      loader = Struct.new(:body) do
        def self.get(_args)
          new(File.read('./spec/support/data/mailinglist_rss_feed.xml'))
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
    text = t("#{model.class.to_s.downcase}.twitter_message", **options)
    Addressable::URI.encode("https://twitter.com/home?status=#{text}")
  end

  def slackin_js
    return if Whitelabel[:slackin_url].blank?

    javascript_include_tag Whitelabel[:slackin_url], async: true, defer: true
  end
end

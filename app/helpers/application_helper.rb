module ApplicationHelper
  def whitelabel_stylesheet_link_tag
    link = "labels/#{Whitelabel[:label_id]}"
    stylesheet_link_tag link if File.exist? Rails.root.join("app/assets/stylesheets/#{link}.sass")
  end

  def whitelabel_javascript_include_tag
    link = "labels/#{Whitelabel[:label_id]}"
    labels = Rails.root.join('app/assets/javascripts/labels').entries.map(&:to_s)
    javascript_include_tag link if labels.any? { |path| path.to_s =~ /#{Whitelabel[:label_id]}/ }
  end

  def label_url(label)
    host = Rails.env.development? ? 'onruby.test' : "onruby.#{label.tld}"
    root_url(subdomain: label.label_id, domain: host)
  end

  def canonical_url
    subdomain = Whitelabel.label ? Whitelabel[:label_id] : 'www'
    options = {
      domain: 'onruby.de',
      subdomain: subdomain,
      only_path: false
    }
    tag :link, rel: :canonical, href: url_for(options)
  end

  def browser_icon
    icon 'shortcut icon'
  end

  def touch_icon
    icon 'apple-touch-icon-precomposed'
  end

  def rss_feed
    auto_discovery_link_tag :rss, events_path(format: :xml), title: 'Event-Feed'
  end

  def icon(type)
    path = image_path Whitelabel.label ? "labels/#{Whitelabel[:label_id]}.ico" : 'favicon.ico'
    tag :link, rel: type, href: path
  end

  def markdown(content)
    return nil unless content
    content = markdown_parser.render(content).html_safe
    content_tag :div, content, class: :markdown
  end

  def section_box(name)
    content_tag :section, class: name, id: name do
      concat content_tag(:h2, content_tag(:i, '', class: "icon icon-#{name}") + t("main.#{name}"))
      yield
    end
  end

  def hint(close = true)
    content_tag(:section, class: :hint) do
      concat content_tag(:div, link_to(t('hint.close'), '#'), class: :close) if close
      yield
    end
  end

  def render_cached(*keys)
    defaults  = [Whitelabel[:label_id], I18n.locale]
    key       = defaults.concat(keys.present? ? keys : [controller_name, action_name]).join('/')

    Rails.logger.info "cache fragment '#{key}'"
    cache(key, expires_in: 4.hours, skip_digest: true) { yield }
  end

  private

  def markdown_parser
    @markdown_parser ||= Redcarpet::Markdown.new Redcarpet::Render::Safe, autolink: true, space_after_headers: true
  end
end

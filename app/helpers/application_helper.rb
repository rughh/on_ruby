module ApplicationHelper
  def whitelabel_stylesheet_link_tag
    link = "labels/#{Whitelabel[:label_id]}"
    stylesheet_link_tag link if File.exists? Rails.root.join("app/assets/stylesheets/#{link}.css.sass")
  end

  def whitelabel_javascript_include_tag
    link = "labels/#{Whitelabel[:label_id]}"
    javascript_include_tag link if File.exists? Rails.root.join("app/assets/javascripts/#{link}.coffee")
  end

  def canonical_url(mobile: false)
    subdomain = Whitelabel.label ? Whitelabel[:label_id] : 'www'
    options = {
      subdomain: subdomain,
      only_path: false
    }
    options[:mobile] = 1 if mobile
    tag :link, rel: :canonical, href: url_for(options)
  end

  def browser_icon
    icon 'shortcut icon'
  end

  def touch_icon
    icon 'apple-touch-icon-precomposed'
  end

  def rss_feed
    auto_discovery_link_tag :rss, events_path(format: :xml), title: "Event-Feed"
  end

  def icon(type)
    path = image_path Whitelabel.label ? "labels/#{Whitelabel[:label_id]}.ico" : "favicon.ico"
    tag :link, rel: type, href: path
  end

  def link_to_user(user)
    link_to user.name, user, title: user.name
  end

  def link_to_job(job)
    link_to job.name, job.url, title: job.name
  end

  def link_to_event(event)
    link_to event.name, event, title: event.name
  end

  def link_to_topic(topic)
    link_to topic.name, topic, title: topic.name
  end

  def job_description(job)
    t("hint.job_description", city: I18n.tw("city"), job_link: content_tag(:strong, link_to(job.name, job.url, title: job.name)), company_link: link_to_location(job.location))
  end

  def link_to_location(location)
    "#{link_to location.name, location, title: location.name} (#{link_to location.nice_url, location.url, title: location.name})".html_safe
  end

  def link_to_route(location)
    content_tag :p, class: :meta do
      content_tag(:span, link_to(location.address, "#route", title: "#{location.name}, #{location.address}"), class: 'map-icon') +
      " #{t("show.at")} " +
      content_tag(:span, link_to_location(location), class: 'open-icon')
    end
  end

  def static_map(*locations)
    options = {
      zoom:     12,
      sensor:   false,
      key:      "AIzaSyBskJCTxAU9UbH3qijy46oNtZ1-4ad14PM",
    }
    params =  options.collect{ |k,v| "#{k}=#{v}" }
    params += locations.map { |l| "markers=#{l.lat},#{l.long}" }
    url = "http://maps.googleapis.com/maps/api/staticmap"
    "#{url}?#{URI.escape(params.join('&'))}"
  end

  def map(locations, init = {zoom: 12})
    locations = Array(locations)
    init = Whitelabel[:location].merge(init)
    data = {
      map: locations.to_json,
      init: init.to_json,
    }
    content_tag :div, '', class: 'map_canvas', data: data
  end

  def markdown(content)
    return nil unless content
    content = markdown_parser.render(content).html_safe
    content_tag :div, content, class: :markdown
  end

  def section_box(name)
    content_tag :section, class: name, id: name do
      concat content_tag(:h2, t(name))
      yield
    end
  end

  def hint(close=true)
    content_tag(:section, class: :hint) do
      concat content_tag(:div, link_to(t("hint.close"), '#'), class: :close) if close
      yield
    end
  end

  def render_cached
    key = [Whitelabel[:label_id], controller_name, action_name].join("/")
    Rails.logger.info "cache fragment '#{key}'"
    cache(key, expires_in: 4.hours, skip_digest: true) { yield }
  end

  private

  def markdown_parser
    @@_markdown_parser ||= Redcarpet::Markdown.new Redcarpet::Render::HTML, autolink: true, space_after_headers: true
  end
end

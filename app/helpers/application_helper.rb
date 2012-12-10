# encoding: UTF-8
module ApplicationHelper
  def title
    I18n.tw("title")
  end

  def subtitle
    I18n.tw("subtitle")
  end

  def contributors
    {
      phoet:          "Peter Schröder",
      rubiii:         "Daniel Harrington",
      ralph:          "Ralph von der Heyden",
      dennisreimann:  "Dennis Reimann",
      jhilden:        "Jakob Hilden",
      SweeD:          "Markus Schwed",
      nistude:        "Nikolay Sturm",
      basiszwo:       "Stefan Botzenhart",
      mustangore:     "Sébastien Jelsch",
    }.map {|key, value| "#{key} (#{value})"}.join(" - ")
  end

  def page_title
    "#{title} - #{content_for?(:page_title) ? content_for(:page_title) : subtitle}"
  end

  def mobile_title
    content_for?(:mobile_title) ? content_for(:mobile_title) : I18n.tw('title')
  end

  def meta_desc
    "#{page_title} - #{I18n.tw("meta_desc")}"
  end

  def whitelabel_stylesheet_link_tag
    link = "labels/#{Whitelabel[:label_id]}"
    stylesheet_link_tag link if File.exists? Rails.root.join("app/assets/stylesheets/#{link}.css.sass")
  end

  def whitelabel_javascript_include_tag
    link = "labels/#{Whitelabel[:label_id]}"
    javascript_include_tag link if File.exists? Rails.root.join("app/assets/javascripts/#{link}.coffee")
  end

  def job_description(job)
    t("hint.job_description", city: I18n.tw("city"), job_link: content_tag(:strong, link_to(job.name, job.url, title: job.name)), company_link: link_to_location(job.location))
  end

  def link_to_location(location)
    "#{link_to location.name, location, title: location.name} (#{link_to location.nice_url, location.url, title: location.name})".html_safe
  end

  def link_to_route(location)
    content_tag :p, class: :meta do
      content_tag(:span, link_to(location.full_address, "#route"), class: 'map-icon') +
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
    cache(key, expires_in: 4.hours) { yield }
  end

  private

  def markdown_parser
    @@_markdown_parser ||= Redcarpet::Markdown.new Redcarpet::Render::HTML, autolink: true, space_after_headers: true
  end
end

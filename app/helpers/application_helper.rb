# frozen_string_literal: true

module ApplicationHelper
  def cache_image_path(model)
    options = {
      timestamp: model.updated_at.to_i,
      model_name: model.class,
      model_id: model.id,
      filename: "#{model.slug}.png",
    }

    image_dispatch_path(options)
  end

  def login_providers
    %w[twitter github google_oauth2]
  end

  def whitelabel_stylesheet_link_tag
    link = "labels/#{Whitelabel[:label_id]}"
    stylesheet_link_tag link if File.exist? Rails.root.join("app/assets/stylesheets/#{link}.sass")
  end

  def whitelabel_javascript_include_tag
    link = "labels/#{Whitelabel[:label_id]}"
    labels = Rails.root.join('app/assets/javascripts/labels').entries.map(&:to_s)
    javascript_include_tag link if labels.any? { |path| path.to_s =~ /#{Whitelabel[:label_id]}/ }
  end

  def label_auth_url(provider)
    host = Rails.env.development? ? "http://#{Whitelabel[:label_id]}.onruby.localhost:3000" : Whitelabel[:canonical_url]

    "#{host}/auth/#{provider}?origin=#{CGI.escape(params[:origin]) if params[:origin]}"
  end

  def label_url(label)
    host = Rails.env.development? ? "#{label.label_id}.onruby.localhost" : label.canonical_url
    root_url(host:)
  end

  def canonical_url
    host = Whitelabel.label ? Whitelabel[:canonical_url] : 'https://www.onruby.eu'
    tag.link rel: :canonical, href: url_for(host:, only_path: false)
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
    tag.link rel: type, href: path
  end

  def markdown(content)
    return nil unless content

    content = markdown_parser.render(content).html_safe
    tag.div(content, class: :markdown)
  end

  def section_box(name)
    tag.section(class: "#{name} clearfix", id: name) do
      concat tag.h2(fa_icon(name, text: t("main.#{name}")))
      yield
    end
  end

  def hint(close = true)
    tag.section(class: :hint) do
      concat tag.div(link_to(t('hint.close'), '#'), class: :close) if close
      yield
    end
  end

  private

  def markdown_parser
    @markdown_parser ||= Redcarpet::Markdown.new Redcarpet::Render::Safe, autolink: true, space_after_headers: true
  end
end

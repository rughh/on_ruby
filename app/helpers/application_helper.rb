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
    %w[twitter github google_oauth2 email]
  end

  def icon_for_provider(provider)
    return 'envelope' if provider == 'email'

    provider
  end

  def whitelabel_stylesheet_link_tag
    link = "labels/#{Whitelabel[:label_id]}"
    stylesheet_link_tag link if File.exist? Rails.root.join("app/assets/stylesheets/#{link}.sass")
  end

  def whitelabel_javascript_include_tag
    link = "labels/#{Whitelabel[:label_id]}"
    javascript_include_tag link if Rails.root.join("app/assets/javascripts/#{link}.js").exist?
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
    return unless host

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

  def label_logo_asset(label_id = Whitelabel[:label_id])
    asset_with_fallback("labels/#{label_id}.png", fallback: 'logo.png')
  end

  def icon(type)
    path = image_path favicon_asset
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

  def user_name(user)
    user.display_name
  end

  private

  def favicon_asset
    return 'favicon.ico' unless Whitelabel.label

    asset_with_fallback("labels/#{Whitelabel[:label_id]}.ico", fallback: 'favicon.ico')
  end

  def asset_with_fallback(logical_path, fallback:)
    return logical_path if asset_file_exists?(logical_path)

    fallback
  end

  def asset_file_exists?(logical_path)
    [
      Rails.root.join('app/assets/images', logical_path),
      Rails.root.join('public', logical_path),
      Rails.root.join('public/images', logical_path)
    ].any?(&:exist?)
  end

  def markdown_parser
    @markdown_parser ||= Redcarpet::Markdown.new Redcarpet::Render::Safe, autolink: true, space_after_headers: true
  end
end

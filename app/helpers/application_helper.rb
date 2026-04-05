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
    fa_icon_map[provider]
  end

  def whitelabel_stylesheet_link_tag
    link = "labels/#{Whitelabel[:label_id]}"
    extensions = %w[css scss sass]
    stylesheet_link_tag link if extensions.any? { |ext| Rails.root.join("app/assets/stylesheets/#{link}.#{ext}").exist? }
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

  def fa_icon_map
    @fa_icon_map ||= ActiveSupport::HashWithIndifferentAccess.new { |_hash, key| key }.merge(
      'events' => 'calendar',
      'topics' => 'comment',
      'people' => 'group',
      'locations' => 'map-marker',
      'google_oauth2' => 'google',
      'email' => 'envelope'
    ).freeze
  end

  def section_box(name)
    tag.section(class: "#{name} clearfix", id: name) do
      concat tag.h2(fa_icon(fa_icon_map[name], text: t("main.#{name}")))
      yield
    end
  end

  def hint(&block)
    tag.section(class: :hint, &block)
  end

  def user_name(user)
    user&.display_name
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
    @markdown_parser ||= Redcarpet::Markdown.new markdown_renderer, autolink: true, space_after_headers: true
  end

  def markdown_renderer
    @markdown_renderer ||= Redcarpet::Render::Safe.new(no_styles: true, filter_html: true, link_attributes: { rel: 'nofollow noopener noreferrer ugc' })
  end
end

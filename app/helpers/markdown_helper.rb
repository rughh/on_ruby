# frozen_string_literal: true

require 'redcarpet/render_strip'

module MarkdownHelper
  def markdown(content)
    return nil unless content

    content = markdown_parser.render(content).html_safe # rubocop:disable Rails/OutputSafety
    tag.div(content, class: :markdown)
  end

  # Plain text for places that can't render HTML (structured data, feeds). Links keep their URL as "text (url)".
  def markdown_to_text(content)
    return nil if content.blank?

    text = markdown_text_parser.render(content)
    Loofah.fragment(text).text(encode_special_chars: false).squeeze("\n").strip
  end

  private

  def markdown_parser
    @markdown_parser ||= Redcarpet::Markdown.new markdown_renderer, autolink: true, space_after_headers: true
  end

  def markdown_renderer
    @markdown_renderer ||= Redcarpet::Render::Safe.new(no_styles: true, filter_html: true, link_attributes: { rel: 'nofollow noopener noreferrer ugc' })
  end

  def markdown_text_parser
    @markdown_text_parser ||= Redcarpet::Markdown.new Redcarpet::Render::StripDown, autolink: true, space_after_headers: true
  end
end

# frozen_string_literal: true

module MarkdownHelper
  def markdown(content)
    return nil unless content

    content = markdown_parser.render(content).html_safe # rubocop:disable Rails/OutputSafety
    tag.div(content, class: :markdown)
  end

  private

  def markdown_parser
    @markdown_parser ||= Redcarpet::Markdown.new markdown_renderer, autolink: true, space_after_headers: true
  end

  def markdown_renderer
    @markdown_renderer ||= Redcarpet::Render::Safe.new(no_styles: true, filter_html: true, link_attributes: { rel: 'nofollow noopener noreferrer ugc' })
  end
end

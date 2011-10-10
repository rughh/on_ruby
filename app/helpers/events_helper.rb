module EventsHelper
  def event_with_tooltip(event)
    content_tag(:h2, event.name) +
    content_tag(:p, event.description) +
    content_tag(:ul, '', class: 'enumeration') do
      event.topics.map do |topic|
        content_tag :li, topic.name
      end.join.html_safe
    end
  end
end
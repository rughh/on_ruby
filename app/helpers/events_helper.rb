module EventsHelper
  def event_with_tooltip(event)
    content_tag(:p, event.description.truncate(100)) +
    content_tag(:ul, '', class: 'enumeration') do
      event.topics.first(3).map do |topic|
        content_tag :li, topic.name
      end.join.html_safe
    end
  end
end
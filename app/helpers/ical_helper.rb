module IcalHelper
  def icalendar(*events)
    RiCal.Calendar do |cal|
      events.each do |event|
        cal.event do |item|
          item.summary     = event.name
          item.description = "#{event.description} #{event_url(event)}"
          item.dtstart     = event.date
          item.dtend       = event.end_date
          item.url         = event_url(event)
          item.location    = event.location.name if event.location
        end
      end
    end.to_s
  end

  def calendar_link
    link_to t('event.subscribe'), calendar_user_url(id: current_user, format: :ics, only_path: false, protocol: 'webcal')
  end
end

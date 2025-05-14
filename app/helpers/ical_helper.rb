# frozen_string_literal: true

module IcalHelper
  def icalendar(*events)
    cal = Icalendar::Calendar.new
    events.map do |event|
      cal.event do |item|
        item.summary     = event.name
        item.description = "#{event.description} #{event_url(event)}"
        item.dtstart     = Icalendar::Values::DateTime.new event.date.utc, tzid: 'UTC'
        item.dtend       = Icalendar::Values::DateTime.new event.end_date.utc, tzid: 'UTC'
        item.url         = event_url(event)
        item.location    = [event.location.name, event.location.address].compact.join(',') if event.location
      end
    end
    cal.to_ical
  end

  def calendar_link
    link_to t('event.subscribe'), calendar_user_url(id: current_user, format: :ics, only_path: false, protocol: 'webcal')
  end
end

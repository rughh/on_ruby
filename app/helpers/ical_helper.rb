module IcalHelper
  def calendar(event)
    ical_event = Icalendar::Event.new.tap do |e|
      e.start         = event.date.strftime("%Y%m%dT%H%M%S")
      e.end           = event.end_date.strftime("%Y%m%dT%H%M%S")
      e.summary       = event.name
      e.description   = "#{event.description} #{event_url(event)}"
      e.location      = event.location.name
      e.created       = event.created_at.strftime("%Y%m%dT%H%M%S")
      e.last_modified = event.updated_at.strftime("%Y%m%dT%H%M%S")
      e.uid = e.url   = event_url(event)
      e.klass         = "PUBLIC"
      e.add_comment "iCal Event by On Ruby!"
    end

    cal = Icalendar::Calendar.new
    cal.add_event(ical_event)
    cal.publish
    cal.to_ical
  end
end

# encoding: utf-8
class EventsController < ApplicationController

  def index
    @upcoming_events = Event.where(:date => (Time.now)..(1.month.from_now)).order("date DESC")
    @events = Event.order("date DESC").paginate :page => params[:page], :per_page => 10
    respond_to do |format|
      format.html
      format.ics { render_ical_calendar(@events) }
    end
  end

  def rss
    @events = Event.order("date DESC").limit(10)
    render :layout => false
    response.headers["Content-Type"] = "application/xml; charset=utf-8"
  end

  def show
    @event = Event.find params[:id]
    respond_to do |format|
      format.html
      format.ics { render_ical_calendar([@event]) }
    end
  end

  def add_user
    event = Event.find params[:id]
    participant = Participant.new do |p|
      p.user = current_user
      p.event = event
    end
    raise particpant.errors unless participant.save
    redirect_to event_path(event), :notice => 'Du bist am Event angemeldet.'
  end

  def publish
    event = Event.find params[:id]
    authorize! :manage, @article
    if event.published?
      redirect_to events_path, :alert => 'Event wurde bereits publiziert.'
    else
      event.publish!(event_url(event))
      redirect_to events_path, :notice => 'Event wurde erfolgreich publiziert.'
    end
  end

  protected
  def render_ical_calendar(events)
    calendar = Icalendar::Calendar.new
    events.each do |event|
      calendar.add_event(ical_event(event))
    end
    calendar.publish
    render :text => calendar.to_ical
  end

  def ical_event(event)
    event.to_ical.tap do |ical_event|
      ical_event.uid = ical_event.url = event_url(event)
    end
  end

end

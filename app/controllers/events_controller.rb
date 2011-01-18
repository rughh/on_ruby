# encoding: utf-8
class EventsController < ApplicationController

  def index
    @events = Event.paginate :page => params[:page], :per_page => 3
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
      format.ics do
        render :text => @event.to_ical(event_url(@event))
      end
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
      event.publish!
      redirect_to events_path, :notice => 'Event wurde erfolgreich publiziert.'
    end
  end

end

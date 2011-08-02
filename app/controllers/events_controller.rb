# encoding: utf-8
class EventsController < ApplicationController
  
  expose(:upcoming_events) { Event.where(:date => (Time.now)..(1.month.from_now)).order("date DESC") }
  expose(:events) { Event.order("date DESC").paginate(:page => params[:page], :per_page => 10) }
  expose(:event)

  def index; end

  def rss
    render :layout => false
    response.headers["Content-Type"] = "application/xml; charset=utf-8"
  end

  def show
    respond_to do |format|
      format.html
      format.ics do
        render :text => event.to_ical(event_url(event))
      end
    end
  end

  def add_user
    participant = Participant.new do |p|
      p.user = current_user
      p.event = event
    end
    raise particpant.errors unless participant.save
    redirect_to event_path(event), :notice => 'Du bist am Event angemeldet.'
  end

end

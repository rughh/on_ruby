# encoding: utf-8
class EventsController < InheritedResources::Base
  load_and_authorize_resource :only => [:show]

  def rss
    @events = Event.order("date DESC").limit(10)
    render :layout => false
    response.headers["Content-Type"] = "application/xml; charset=utf-8"
  end

  def show
    respond_to do |format|
      format.html
      format.ics do
        render :text => @event.to_ical(event_url(@event))
      end
    end
  end

  def info
  end

end

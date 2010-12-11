# encoding: utf-8
class EventsController < InheritedResources::Base
  load_and_authorize_resource :except => :info
  
  def rss
    @events = Event.order("id DESC").limit(10)
    render :layout => false
    response.headers["Content-Type"] = "application/xml; charset=utf-8"
  end
  
  def show
    respond_to do |format|
      format.html
      format.ics do
        calendar = Icalendar::Calendar.new
        calendar.add_event(@event.to_ics(event_url(@event)))
        calendar.publish
        render :text => calendar.to_ical
      end
    end
  end
  
  def create
    if params['add_material']
      add_material
    else
      super
    end
  end
  
  def info
    @users = {      
      'Jan Krutisch' => 'https://www.xing.com/profile/Jan_Krutisch',
      'Ralph von der Heyden' => 'https://www.xing.com/profile/Ralph_vonderHeyden',
      'Peter Schröder' => 'https://www.xing.com/profile/peter_schroeder2',
      'Daniel Harrington' =>'https://www.xing.com/profile/Daniel_Harrington'
    }
  end
  
  private
  
  def add_material
    @event = Event.new params['event']
    @event.materials.build
    render :new
  end
  
end

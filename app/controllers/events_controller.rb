# encoding: utf-8
class EventsController < InheritedResources::Base
  load_and_authorize_resource :except => [:info, :rss]
  
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
    @users = {      
      'Jan Krutisch' => 'https://www.xing.com/profile/Jan_Krutisch',
      'Ralph von der Heyden' => 'https://www.xing.com/profile/Ralph_vonderHeyden',
      'Peter Schröder' => 'https://www.xing.com/profile/peter_schroeder2',
      'Daniel Harrington' =>'https://www.xing.com/profile/Daniel_Harrington'
    }
  end
end

class EventsController < InheritedResources::Base
  
  def rss
    @events = Event.order("id DESC").limit(10)
    render :layout => false
    response.headers["Content-Type"] = "application/xml; charset=utf-8"
  end
  
  def show
    @event = params[:id] ? Event.find(params[:id]) : Event.current
    flash[:alert] = 'Derzeit sind keine aktuellen Termine vorhanden' unless @event
  end
  
  def create
    if params['add_material']
      add_material
    else
      super
    end
  end
  
  private
  
  def add_material
    @event = Event.new params['event']
    @event.materials.build
    render :new
  end
  
end

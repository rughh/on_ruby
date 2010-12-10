class EventsController < InheritedResources::Base
  
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

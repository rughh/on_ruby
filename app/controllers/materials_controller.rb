# encoding: utf-8
class MaterialsController < InheritedResources::Base
  load_and_authorize_resource
  
  belongs_to :event
  
  def create
    @event = Event.find(params[:event_id])
    @topic = @event.materials.create!(params[:material])
    redirect_to @event, :notice => 'Neues Material erzeugt!'
  end
  
  def destroy
    @event = Event.find(params[:event_id])
    Material.find(params[:id]).destroy
    redirect_to @event, :notice => 'Material wurde gelöscht!'
  end
  
end

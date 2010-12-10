# encoding: utf-8
class TopicsController < InheritedResources::Base
  belongs_to :event
  
  def create
    @event = Event.find(params[:event_id])
    @topic = @event.topics.create!(params[:topic])
    redirect_to @event, :notice => 'Neues Thema erzeugt!'
  end
  
  def destroy
    @event = Event.find(params[:event_id])
    Topic.find(params[:id]).destroy
    redirect_to @event, :notice => 'Thema wurde gelöscht!'
  end
  
end

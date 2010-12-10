class TopicsController < InheritedResources::Base
  belongs_to :event
  
  def create
    @event = Event.find(params[:event_id])
    @topic = @event.topics.create!(params[:topic])
    redirect_to @event, :notice => 'Neues Thema erzeugt!'
  end
  
end

class ParticipantsController < InheritedResources::Base
  load_and_authorize_resource
  
  def add_user
    event = Event.find(params[:id])
    participant = Participant.new
    participant.user = current_user
    participant.event = event
    raise particpant.errors unless participant.save
    redirect_to(event_path(event), :notice => 'Du bist am Event angemeldet.')
  end
  
  def destroy
    participant = Participant.find(params[:id])
    event = participant.event
    participant.destroy
    redirect_to(event_path(event), :notice => 'Du bist vom Event abgemeldet.')
  end
end

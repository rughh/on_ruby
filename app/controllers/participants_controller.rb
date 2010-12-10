class ParticipantsController < InheritedResources::Base
  def add_user
    event = Event.find(params[:id])
    @participant = Participant.new
    @participant.user = current_user
    @participant.event = event
    raise @particpant.errors unless @participant.save
    redirect_to(event_path(event), :notice => 'Du bist am Event angemeldet.')
  end
  
  def destroy
    destroy! do |format|
      format.html { redirect_to(root_url, :notice => 'Du bist vom Event abgemeldet.') }
    end
  end
end

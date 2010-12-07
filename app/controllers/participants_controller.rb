class ParticipantsController < InheritedResources::Base
  def create
    @participant = Participant.new(params[:participant])
    raise @particpant.errors unless @participant.save
    redirect_to(root_path, :notice => 'Du bist am Event angemeldet.')
  end
  
  def destroy
    destroy! do |format|
      format.html { redirect_to(root_url, :notice => 'Du bist vom Event abgemeldet.') }
    end
  end
end

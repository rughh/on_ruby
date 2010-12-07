class ParticipantsController < InheritedResources::Base
  def create
    @participant = Participant.new(params[:participant])
    raise @particpant.errors unless @participant.save
    redirect_to(root_path)
  end
end

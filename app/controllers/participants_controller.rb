class ParticipantsController < ApplicationController
  def destroy
    participant = Participant.find params[:id]
    event = participant.event
    participant.destroy
    redirect_to event_path(event), :notice => 'Du bist vom Event abgemeldet.'
  end
end

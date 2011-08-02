# encoding: utf-8

class ParticipantsController < ApplicationController
  def destroy
    participant = Participant.find params[:id]
    if participant.owned_by? current_user
      participant.destroy
      redirect_to event_path(participant.event), :notice => 'Du bist vom Event abgemeldet.'
    else
      redirect_to event_path(participant.event), :alert => 'Hoppala, diese Anmeldung darfst du nicht löschen!'
    end
  end
end

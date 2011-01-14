# encoding: utf-8

class ParticipantsController < ApplicationController
  def destroy
    participant = Participant.find params[:id]
    event = participant.event
    if participant.owned_by? current_user
      participant.destroy
      redirect_to event_path(event), :notice => 'Du bist vom Event abgemeldet.'
    else
      redirect_to event_path(event), :alert => 'Hoppala, diese Anmeldung darfst du nicht löschen!'
    end
  end
end


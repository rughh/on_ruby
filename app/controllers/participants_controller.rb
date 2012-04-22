class ParticipantsController < ApplicationController
  def destroy
    participant = Participant.find params[:id]
    if participant.owned_by? current_user
      participant.destroy
      redirect_to event_path(participant.event), notice: t("flash.dont_participate")
    else
      redirect_to event_path(participant.event), alert: t("flash.forbidden")
    end
  end
end

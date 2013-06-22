class ParticipantsController < ApplicationController
  before_action :authenticate!
  respond_to :html, :json

  expose(:event)

  def create
    if current_user.participates?(event)
      respond_with(event) do |format|
        format.html { redirect_to event_path(event), alert: t("flash.already_participating") }
        format.json { head(200) }
      end
    else
      event.participants.create!(user: current_user)
      respond_with(event) do |format|
        format.html { redirect_to event_path(event), notice: t("flash.now_participating") }
        format.json { head(201) }
      end
    end
  end

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

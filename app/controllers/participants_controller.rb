class ParticipantsController < ApplicationController
  before_action :authenticate!

  expose(:event) { Event.from_param(params[:event_id]) }

  def create
    if event.closed?
      flash[:alert] = t('flash.already_closed')
    elsif event.particpate(current_user)
      flash[:notice] = t('flash.now_participating')
    else
      flash[:alert] = t('flash.already_participating')
    end
    redirect_to event_path(event)
  end

  def destroy
    participant = Participant.find params[:id]
    if participant.owned_by? current_user
      participant.destroy
      redirect_to event_path(participant.event), notice: t('flash.dont_participate')
    else
      redirect_to event_path(participant.event), alert: t('flash.forbidden')
    end
  end
end

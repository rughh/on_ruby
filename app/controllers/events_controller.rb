class EventsController < ApplicationController
  before_filter :check_login, only: :add_user

  expose(:events) { Event.ordered }
  expose(:event) { Event.includes(materials: :user, topics: :user, participants: :user).find(params[:id]) }

  respond_to :html, :mobile, :json, only: :add_user
  respond_to :xml, only: :index
  respond_to :json, :ics, only: :show

  def index; end

  def show
    respond_to do |format|
      format.html
      format.json do
        render json: event.as_api_response(:ios_v1)
      end
      format.ics do
        render text: event.to_ical(event_url(event))
      end
    end
  end

  def add_user
    if current_user.participates?(event)
      respond_with(event) do |format|
        format.html { redirect_to event_path(event), alert: t("flash.already_participating") }
        format.mobile { redirect_to event_path(event), alert: t("flash.already_participating") }
        format.json { head(200) }
      end
    else
      event.participants.create!(user: current_user)
      respond_with(event) do |format|
        format.html { redirect_to event_path(event), notice: t("flash.now_participating") }
        format.mobile { redirect_to event_path(event), notice: t("flash.now_participating") }
        format.json { head(201) }
      end
    end
  end
end

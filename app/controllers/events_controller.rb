class EventsController < ApplicationController
  before_filter :check_login, only: :add_user

  expose(:events) { Event.ordered }
  expose(:event)

  respond_to :html, :mobile, :json, only: :add_user
  respond_to :xml, only: :rss
  respond_to :ics, only: :show

  def rss; end

  def show
    respond_to do |format|
      format.html
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

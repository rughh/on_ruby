class EventsController < ApplicationController
  before_filter :check_login, only: :add_user

  expose(:events) { Event.ordered }
  expose(:event)

  respond_to :xml, only: :rss

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
      redirect_to event_path(event), alert: t("flash.already_participating")
    else
      event.participants.create!(user: current_user)
      redirect_to event_path(event), notice: t("flash.now_participating")
    end
  end
end

class EventsController < ApplicationController
  expose(:events) { Event.ordered }
  expose(:event)

  def rss
    render layout: false
    response.headers["Content-Type"] = "application/xml; charset=utf-8"
  end

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

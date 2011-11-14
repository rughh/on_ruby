# encoding: utf-8
class EventsController < ApplicationController

  expose(:events) { Event.order("date DESC").limit(10) }
  expose(:event)

  def index
    respond_to do |format|
      format.html
      format.json { render_for_api :ios, :json => events }
    end
  end

  def rss
    render :layout => false
    response.headers["Content-Type"] = "application/xml; charset=utf-8"
  end

  def show
    respond_to do |format|
      format.html
      format.ics do
        render :text => event.to_ical(event_url(event))
      end
    end
  end

  def add_user
    if current_user.participates?(event)
      redirect_to event_path(event), :alert => 'Du bist schon angemeldet.'
    else
      event.participants.create!(:user => current_user)
      redirect_to event_path(event), :notice => 'Du bist am Event angemeldet.'
    end
  end

end

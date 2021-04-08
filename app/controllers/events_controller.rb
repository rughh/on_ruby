# frozen_string_literal: true

class EventsController < ApplicationController
  include IcalHelper

  expose(:events) { Event.ordered.page(params[:page]) }
  expose(:event)  { Event.includes(materials: :user, topics: :user, participants: :user).from_param(params[:id]) }

  def index
    respond_to do |format|
      format.html
      format.xml  { render layout: false }
      format.json { render json: events.as_api_response(:ios_v1) }
      format.ics  { render plain: icalendar(*events) }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json do
        render json: event.as_api_response(:ios_v1)
      end
      format.ics do
        render plain: icalendar(event)
      end
    end
  end

  def rsvp
    if signed_in?
      if event.closed?
        flash[:alert] = t('flash.already_closed')
      elsif event.particpate(current_user)
        flash[:notice] = t('flash.now_participating')
      else
        flash[:alert] = t('flash.already_participating')
      end
      redirect_to event_path(event)
    else
      redirect_to '/auth/linkedin'
    end
  end
end

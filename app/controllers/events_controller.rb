class EventsController < ApplicationController
  include IcalHelper

  expose(:events) { Event.ordered.page(params[:page]).per(10) }
  expose(:event) { Event.includes(materials: :user, topics: :user, participants: :user).friendly.find(params[:id]) }

  respond_to :json, :xml, only: :index
  respond_to :json, :ics, only: :show

  def index
    respond_to do |format|
      format.html
      format.xml
      format.json do
        render json: events.as_api_response(:ios_v1)
      end
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json do
        render json: event.as_api_response(:ios_v1)
      end
      format.ics do
        render text: icalendar(event)
      end
    end
  end
end

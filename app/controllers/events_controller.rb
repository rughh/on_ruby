class EventsController < ApplicationController
  
  def index
    @events = Event.all
  end
  
  def show
    @event = params[:id] ? Event.find(params[:id]) : Event.current
  end
  
  def new
    @event = Event.new
  end
end

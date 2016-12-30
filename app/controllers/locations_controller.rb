class LocationsController < ApplicationController
  # REM (ps): location is a reserved method!
  expose(:current_location) { Location.find params[:id] }
  expose(:locations)        { Location.ordered }
  expose(:organizers)       { User.organizers }
  expose(:stats)            { Event.stats }

  def index; end

  def show; end

  def none; end
end

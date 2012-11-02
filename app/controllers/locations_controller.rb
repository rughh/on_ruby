class LocationsController < ApplicationController
  # REM (ps): location is a reserved method!
  expose(:current_location, model: :location)
  expose(:locations)

  def index; end
  def show; end
end

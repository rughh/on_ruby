class LocationsController < ApplicationController
  # REM (ps): location is a reserved method!
  expose(:current_location, model: :location)
  expose(:locations) { Location.cometogether }
  expose(:companies) { Location.company }

  def index; end
  def show; end
  def company; end
end

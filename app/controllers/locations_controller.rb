class LocationsController < ApplicationController
  # REM (ps): location is a reserved method!
  expose(:current_location) { Location.find params[:id] }
  expose(:locations)

  def index; end
  def show; end
end

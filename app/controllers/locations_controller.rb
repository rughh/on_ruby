class LocationsController < ApplicationController
  # REM (ps): location is a reserved method!
  expose(:current_location) { Location.find params[:id] }
  expose(:locations) { Location.ordered }

  def index; end
  def show; end
end

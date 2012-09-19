class LocationsController < ApplicationController
  expose(:location) { Location.find params[:id] }
  expose(:locations) { Location.cometogether }
  expose(:companies) { Location.company }

  def index; end
  def show; end
  def company; end
end

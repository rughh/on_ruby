class LocationsController < ApplicationController

  expose(:locations) { Location.cometogether }
  expose(:companies) { Location.company }

  def index; end

  def company; end

end

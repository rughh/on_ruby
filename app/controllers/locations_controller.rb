class LocationsController < ApplicationController

  expose(:locations) { Location.cometogether }
  expose(:companies) { Location.company }

  def index
    respond_to do |format|
      format.html
      format.json { render_for_api :ios, :json => Location.all }
    end
  end

  def company; end

end

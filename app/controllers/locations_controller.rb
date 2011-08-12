class LocationsController < ApplicationController

  expose(:locations) { Location.cometogether.paginate(page: params[:page], per_page: 5) }
  expose(:companies) { Location.company.paginate(page: params[:page], per_page: 5) }

  def index; end
  def company; end

end

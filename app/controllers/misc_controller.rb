class MiscController < ActionController::Base
  respond_to :xml

  def sitemap
    render layout: false
  end
end

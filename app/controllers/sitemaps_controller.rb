class SitemapsController < ActionController::Base
  respond_to :xml

  def show
    render layout: false
  end
end

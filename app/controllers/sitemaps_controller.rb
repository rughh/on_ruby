class SitemapsController < ApplicationController
  respond_to :xml

  def show
    render layout: false
  end
end

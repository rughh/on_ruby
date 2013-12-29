class LabelsController < ActionController::Base
  before_action :setup

  def index
    render layout: 'labels'
  end

  private

  def setup
    Whitelabel.reset!
  end
end

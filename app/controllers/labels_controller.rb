class LabelsController < ActionController::Base
  include MobileDetection

  before_action :setup

  def index
    render layout: "#{mobile_device? ?  'application'  : 'labels'}"
  end

  private

  def setup
    Whitelabel.reset!
    check_for_mobile
  end
end

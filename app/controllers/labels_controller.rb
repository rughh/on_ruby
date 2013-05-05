class LabelsController < ActionController::Base
  include MobileDetection

  before_filter :check_for_mobile

  def index
    render layout: "#{mobile_device? ?  'application'  : 'labels'}"
  end
end

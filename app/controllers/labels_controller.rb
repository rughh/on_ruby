class LabelsController < ActionController::Base
  include LocaleDetection
  before_action :setup

  def index
    render layout: 'labels'
  end

  private

  def setup
    Whitelabel.reset!
    switch_locale
  end
end

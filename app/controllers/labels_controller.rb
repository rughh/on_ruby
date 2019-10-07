# frozen_string_literal: true

class LabelsController < ActionController::Base
  include LocaleDetection
  protect_from_forgery with: :exception
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

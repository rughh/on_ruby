class Admin::ApplicationController < Admin::ResourcesController
  include WhitelabelDetection
  include LocaleDetection
  include TimeZoneDetection

  before_action :setup

  protected

  def setup
    switch_label
    switch_locale
    switch_time_zone
  end
end

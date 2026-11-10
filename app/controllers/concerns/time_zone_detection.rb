# frozen_string_literal: true

module TimeZoneDetection
  protected

  def switch_time_zone
    Time.zone = Whitelabel.label ? Whitelabel[:default_time_zone] : Rails.configuration.time_zone
  end
end

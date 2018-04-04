module TimeZoneDetection
  protected

  def switch_time_zone
    time_zone = params[:time_zone]

    if allowed_time_zone?(time_zone)
      Time.zone = time_zone
    else
      Time.zone = default_time_zone
    end
  end

  def allowed_time_zone?(time_zone)
    time_zone && ActiveSupport::TimeZone.new(time_zone).present?
  end

  def default_time_zone
    Whitelabel.label ? Whitelabel[:default_time_zone] : Rails.configuration.time_zone
  end
end

require 'active_support/concern'

module MobileDetection
  extend ActiveSupport::Concern

  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end

  def prepare_for_mobile
    session[:mobile_param] = params[:mobile] if params[:mobile]
    request.format = :mobile if mobile_device? && !params[:format]
  end
end

# encoding: UTF-8
class ApplicationController < ActionController::Base
  include ActionCaching

  protect_from_forgery

  # REM: order matters!
  before_filter :reset_locales
  before_filter :switch_label, :switch_locale
  before_filter :prepare_for_mobile

  helper_method :current_user, :signed_in?
  helper_method :mobile_device?

  cache_sweeper :index_sweeper

  expose(:jobs)       { Job.shuffled }
  expose(:main_user)  { User.main }
  expose(:highlights) { Highlight.active }

  def check_login
    redirect_to(auth_path) unless signed_in?
  end

  protected

  def authenticate_admin_user!
    unless current_user.try(:admin?)
      redirect_to root_path, alert: t("flash.only_admins")
    end
  end

  def authenticate_current_user!
    unless current_user and current_user == user
      redirect_to root_path, alert: t("flash.not_authenticated")
    end
  end

  def current_user
    @current_user ||= User.find_by_session_or_cookies(session, cookies)
  end

  def signed_in?
    !!current_user
  end

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.id
  end

  def reset_locales
    # REM (ps): thread locales need to be reset, when shared between requests!
    Whitelabel.reset!
    I18n.locale = I18n.default_locale
  end

  def switch_label
    unless Usergroup.switch_by_request(request)
      redirect_to labels_url(subdomain: false)
    end
  end

  def switch_locale
    locale = params[:locale] || cookies[:locale]
    locale ||= Whitelabel[:default_locale] if Whitelabel.label
    cookies[:locale] = I18n.locale = locale
  end

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

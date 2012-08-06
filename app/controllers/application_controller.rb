# encoding: UTF-8
class ApplicationController < ActionController::Base

  protect_from_forgery
  before_filter :switch_label, :switch_locale
  helper_method :current_user, :signed_in?

  expose(:jobs)       { Job.shuffled }
  expose(:main_user)  { User.main }
  expose(:highlights) { Highlight.active }

  def check_login
    redirect_to(auth_path) unless signed_in?
  end

  def default_url_options(options={})
    options.merge locale: I18n.locale
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

  def switch_label
    unless Usergroup.switch_by_request(request)
      redirect_to labels_url(subdomain: false)
    end
  end

  def switch_locale
    I18n.locale = params[:locale] || Whitelabel[:default_locale]
  end
end

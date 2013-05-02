# encoding: UTF-8
class ApplicationController < ActionController::Base
  include MobileDetection

  protect_from_forgery

  before_filter :setup

  helper_method :current_user
  helper_method :signed_in?, :mobile_device?

  cache_sweeper :index_sweeper

  rescue_from ActiveRecord::RecordNotFound, with: :_404
  rescue_from ActionView::MissingTemplate,  with: :_404

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

  def setup
    reset_thread_locales
    switch_label
    switch_locale
    check_for_mobile
  end

  def reset_thread_locales
    Whitelabel.reset!
    I18n.locale = I18n.default_locale
  end

  def switch_label
    controller_action = "#{controller_name}_#{action_name}"
    # TODO (ps) split up the logic and use includes instead of checking the actions
    return if %w(home_labels misc_sitemap).include?(controller_action)
    unless Usergroup.switch_by_request(request)
      redirect_to labels_url(subdomain: false)
    end
  end

  def switch_locale
    locale = params[:locale] || cookies[:locale]
    locale ||= Whitelabel[:default_locale] if Whitelabel.label
    locale ||= I18n.default_locale
    I18n.locale = locale
    cookies[:locale] = {
      value:   locale,
      expires: 1.year.from_now,
      domain:  request.domain
    }
  end

  def _404(exception)
    Rails.logger.warn exception
    Rails.logger.warn "head 404 with params #{params}"
    head 404
  end
end

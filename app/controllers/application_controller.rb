# encoding: UTF-8
class ApplicationController < ActionController::Base
  protect_from_forgery

  expose(:main_user)  { User.main }
  expose(:jobs)       { Job.all.shuffle }
  expose(:highlights) { Highlight.active }

  helper_method :current_user, :signed_in?, :preview_events, :tweets, :random_users

  before_filter :switch_locale, :switch_label

  def check_login
    redirect_to(auth_path) unless signed_in?
  end

  def default_url_options(options={})
    options.merge locale: I18n.locale
  end

  protected

  def authenticate_admin_user!
    unless current_user.try(:admin?)
      redirect_to(root_path, alert: t("flash.only_admins")) and return
    end
  end

  def authenticate_current_user!
    unless current_user and current_user == user
      redirect_to(root_path, alert: t("flash.not_authenticated")) and return
    end
  end

  def current_user
    @current_user ||= find_by_session_or_cookie
  end

  def signed_in?
    !!current_user
  end

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.id
  end

  def switch_label
    return if Whitelabel.label_for(request.subdomains.first)

    Whitelabel.labels.each do |label|
      if label.domains && label.domains.any? { |custom_domain| request.host =~ /#{custom_domain}/ }
        Whitelabel.label = label and return
      end
    end
    redirect_to(labels_url(subdomain: false), alert: t("flash.no_whitelabel"))
  end

  def switch_locale
    I18n.locale = params[:locale] || :de
  end

  def find_by_session_or_cookie
    User.find_by_id session[:user_id] || User.authenticated_with_token(*(cookies.signed[:remember_me] || ['', '']))
  end
end

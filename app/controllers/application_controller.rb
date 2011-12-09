# encoding: UTF-8
class ApplicationController < ActionController::Base

  protect_from_forgery

  expose(:main_user) { User.main }

  helper_method :current_user, :signed_in?, :preview_events, :tweets, :random_users

  def check_login
    redirect_to(auth_path) unless signed_in?
  end

  protected()

  def authenticate_admin_user!
    unless current_user.try(:admin?)
      redirect_to(root_path, alert: 'Hoppala, da dürfen nur Admins hin!') and return
    end
  end

  def authenticate_current_user!
    unless current_user and current_user == user
      redirect_to(root_path, alert: 'Hoppala, diese Seite ist nicht für dich bestimmt!') and return
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

  def find_by_session_or_cookie
    User.find_by_id session[:user_id] || User.authenticated_with_token(*(cookies.signed[:remember_me] || ['', '']))
  end

end

# encoding: UTF-8
class ApplicationController < ActionController::Base

  protect_from_forgery

  helper_method :current_user, :signed_in?, :preview_events, :tweets, :random_users

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message
    redirect_to root_url
  end

  def check_login
    redirect_to(auth_path) unless signed_in?
  end

  private()

  def authenticate_admin_user!
    unless current_user.try(:admin?)
      redirect_to(root_path, :notice => 'Hoppala, da dürfen nur Admins hin!') and return
    end
  end

  def current_user
    @current_user ||= User.find_by_id session[:user_id]
  end

  def signed_in?
    !!current_user
  end

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.id
  end

end

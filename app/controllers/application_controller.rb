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

  def preview_events
    @preview_events ||= Event.preview_events
  end

  def tweets
    cache(:tweets, :expires_in => 5.minutes) do
      random_users[0..2].map do |user|
        logger.debug "fetching new tweets for #{user.nickname}"
        Twitter::Search.new.from(user.nickname).fetch
      end.flatten
    end.shuffle[0..1]
  rescue
    []
  end

  def random_users
    cache(:random_users, :expires_in => 1.minute) do
      User.random
    end
  end
end

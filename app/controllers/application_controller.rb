class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :check_login_path

  helper_method :current_user, :signed_in?, :preview_events, :tweets, :random_users

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message
    redirect_to root_url
  end

  protected

  def check_login
    redirect_to(auth_path) unless signed_in?
  end

  private

  def check_login_path
    path = session[:login_path]
    if path && signed_in?
      session[:login_path] = nil
      redirect_to path, :notice => "Hallo #{current_user.nickname}!"
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
      search = random_users[0..3].map(&:nickname).join(' OR ')
      logger.debug "fetching new tweets for #{search}"
      Twitter::Search.new.from(search).fetch[0..10]
    end
  rescue
    []
  end

  def random_users
    cache(:random_users, :expires_in => 1.minute) do
      User.random
    end
  end

end

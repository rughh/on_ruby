class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :load_stuff
  helper_method :current_user, :signed_in?
  
  private
  
  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def signed_in?
    !!current_user
  end

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.id
  end

  def load_stuff
    @tweets = cache(:tweets, :expires_in => 1.minute) do
      logger.debug "fetching new tweets"
      Twitter::Search.new.q("rails OR ruby OR rughh").geocode(53.561858,9.962021,'100km').rpp(5).fetch
    end
    @preview_events = Event.preview_events
    @random_users = User.random
  end
end

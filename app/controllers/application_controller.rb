class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :load_stuff
  
  def load_stuff
    @tweets = cache(:tweets, :expires_in => 1.minute) do
      logger.debug "fetching new tweets"
      Twitter::Search.new.q("rails OR ruby OR rughh").geocode(53.561858,9.962021,'100km').rpp(5).fetch
    end
    @preview_events = Event.preview_events
  end
end

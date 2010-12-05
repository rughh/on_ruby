class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :load_stuff
  
  def load_stuff
    @tweets = cache(:tweets, :expire_in => 1.minute) do
      logger.debug "fetching new tweets"
      Twitter::Search.new.q("rails").fetch
    end
    @preview_events = Event.preview_events
  end
end

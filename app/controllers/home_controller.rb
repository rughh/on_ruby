class HomeController < ApplicationController
  def index
    @tweets = cache(:tweets, :expire_in => 1.minute) do
      logger.debug "fetching new tweets"
      Twitter::Search.new.q("rails").fetch
    end

  end
end

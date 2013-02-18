class ApiController < ApplicationController
  before_filter :api_sign_in

  expose(:topics)     { [] } # TODO
  expose(:locations)  { Location.all }
  expose(:events)     { Event.ordered }
  expose(:users)      { User.ordered }

  def index
    hash = {
      topics:     topics.as_api_response(:ios_v1),
      locations:  locations.as_api_response(:ios_v1),
      events:     events.as_api_response(:ios_v1),
      users:      users.as_api_response(:ios_v1),
    }
    respond_to do |format|
      format.json { render text: hash.to_json }
    end
  end

  private

  def api_sign_in
    if request.format.json?
      if request.headers["x-api-key"] != ENV["HOR_API_KEY"]
        head :unauthorized
      end
    end
  end
end

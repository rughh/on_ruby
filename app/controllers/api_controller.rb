class ApiController < ApplicationController
  before_action :api_sign_in

  expose(:topics)     { Topic.all }
  expose(:locations)  { Location.all }
  expose(:events)     { Event.ordered }
  expose(:users)      { User.ordered }

  respond_to :json

  def index
    hash = {
      topics:     topics.as_api_response(:ios_v1),
      locations:  locations.as_api_response(:ios_v1),
      events:     events.as_api_response(:ios_v1),
      users:      users.as_api_response(:ios_v1),
    }
    respond_with(hash)
  end

  def flush
    Rails.cache.clear

    respond_with({result: :ok})
  end

  private

  def api_sign_in
    if request.format.json?
      key = request.headers["x-api-key"] || params["x-api-key"]
      if key != ENV["HOR_API_KEY"]
        head :unauthorized
      end
    end
  end
end

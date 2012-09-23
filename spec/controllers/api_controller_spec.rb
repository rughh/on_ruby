require 'spec_helper'

describe ApiController do

  before { set_subdomain }

  describe "GET :index" do
    before do
      request.env['x-api-key'] = ''
    end

    it "should redirect and have status not_authorized" do
      get :index, format: :json
      response.status.should eql(401)
      response.body.should eql(' ')
    end

    it "should render json with valid api-key" do
      request.env['x-api-key'] = ENV["HOR_API_KEY"] = 'bla'
      get :index, format: :json
      response.status.should eql(200)
      JSON.parse(response.body).keys.should eql(["wishes", "locations", "events", "users"])
    end
  end
end

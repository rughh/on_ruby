require 'spec_helper'

describe "Api" do
  context "authorization" do
    before do
      ENV["HOR_API_KEY"] = "bla"
    end

    it "should redirect and have status not_authorized" do
      get api_path(format: :json), nil, 'x-api-key' => ''
      response.status.should eql(401)
      response.body.should eql(' ')
    end

    it "should render json with valid api-key" do
      get api_path(format: :json), nil, 'x-api-key' => ENV["HOR_API_KEY"]
      response.status.should eql(200)
      JSON.parse(response.body).keys.should eql(["topics", "locations", "events", "users"])
    end
  end
end

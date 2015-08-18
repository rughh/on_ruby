require 'spec_helper'

describe "Api" do
  context "authorization" do
    before do
      ENV["HOR_API_KEY"] = "bla"
    end

    it "should redirect and have status not_authorized" do
      get api_path(format: :json), nil, 'x-api-key' => ''
      expect(response.status).to eql(401)
      expect(response.body).to be_empty
    end

    it "should render json with valid api-key" do
      get api_path(format: :json), nil, 'x-api-key' => ENV["HOR_API_KEY"]
      expect(response).to be_ok
      expect(JSON.parse(response.body).keys).to eql(["topics", "locations", "events", "users"])
    end
  end
end

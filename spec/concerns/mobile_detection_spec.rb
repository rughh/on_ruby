require "spec_helper"

describe HomeController, type: :request do
  context "request format" do
    it "should have a request type of text/html" do
      get root_path

      response.body.should match("/assets/application.js")
    end

    it "should have a mobile request alias" do
      get root_path, nil, "HTTP_USER_AGENT" => "Mobile Safari"

      response.body.should match("viewport")
      response.body.should match("mobile")
    end
  end
end

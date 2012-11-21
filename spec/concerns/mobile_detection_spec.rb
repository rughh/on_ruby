require "spec_helper"

describe HomeController, type: :controller do

  before { set_subdomain }

  describe "request format" do
    it "should have a request type of text/html" do
      get :index

      controller.request.format.should_not be_mobile
      controller.request.format.to_s.should eql("text/html")
    end

    it "should have a mobile request alias" do
      controller.request.stubs(user_agent: "Mobile Safari")
      get :index

      controller.request.format.should be_mobile
      controller.request.format.to_s.should eql("text/html")
    end
  end
end

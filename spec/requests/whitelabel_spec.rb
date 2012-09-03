require "spec_helper"

describe "Whitelabel" do
  describe "GET page with non existing subdomain" do
    it "redirects to main url" do
      get root_url(subdomain: "rostock")
      response.should redirect_to(labels_url(subdomain: false))
    end
  end

  describe "GET page with existing subdomain" do
    it "shows the label" do
      get root_url(subdomain: "hamburg")
      response.should be_success
    end
  end

  describe "GET page with custom domain" do
    before { ActionDispatch::Request.any_instance.stubs(:host).returns("www.colognerb.de") }

    it "shows the label" do
      get root_url
      response.should be_success
    end
  end
end

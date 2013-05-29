require "spec_helper"

describe "Whitelabel" do
  context "GET label page with non existing subdomain" do
    it "does not do an endless redirect but halts" do
      host! 'www.onruby.dev'
      get labels_path
      response.should be_success
    end
  end

  context "GET page with non existing subdomain" do
    it "redirects to main url" do
      get root_url(subdomain: "rostock")
      response.should redirect_to(labels_url(subdomain: 'www'))
    end
  end

  context "GET page with existing subdomain" do
    it "shows the label" do
      get root_url(subdomain: "hamburg")
      response.should be_success
    end
  end

  context "GET page with custom domain" do
    it "shows the label" do
      host! 'www.colognerb.de'
      get root_url
      response.should be_success
      Whitelabel[:label_id].should eql("cologne")
    end
  end
end

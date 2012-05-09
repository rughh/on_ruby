require "spec_helper"

describe "Whitelabel" do

  describe "GET page with non existing subdomain" do
    it "redirects to main url" do
      get root_url(subdomain: "harburg")
      response.should redirect_to(root_url(subdomain: false, locale: 'de'))
      flash[:alert].should == I18n.t('flash.no_whitelabel')
    end
  end

  describe "GET page with existing subdomain" do
    it "shows the whitelabel" do
      get root_url(subdomain: "hamburg")
      response.should be_success
    end
  end

end

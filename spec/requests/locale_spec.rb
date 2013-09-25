require "spec_helper"

describe "Locale" do
  context "GET page without a locale" do
    it "should have the default locale" do
      get root_url(subdomain: "hamburg")
      I18n.locale.should be(:de)
    end
  end

  context "GET page with a different default locale" do
    before { Whitelabel.labels.first.stub(default_locale: :en) }

    it "should have a different default locale" do
      get root_url(subdomain: "hamburg")
      I18n.locale.should be(:en)
    end
  end

  context "GET page with a locale cookie" do
    it "sets the locale via cookie" do
      get root_url(subdomain: "hamburg")
      I18n.locale.should be(:de)
      get root_url(subdomain: "hamburg", locale: :en )
      I18n.locale.should be(:en)
      get root_url(subdomain: "hamburg")
      I18n.locale.should be(:en)
    end
  end

  context "GET page with a locale param" do
    it "should set the requested locale over the cookie and default locale" do
      get root_url(subdomain: "hamburg", locale: :fr )
      I18n.locale.should be(:fr)
      get root_url(subdomain: "hamburg", locale: :en)
      I18n.locale.should be(:en)
    end
  end
end

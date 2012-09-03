require "spec_helper"

describe "Locale" do
  describe "GET page without a locale" do
    it "should have the default locale" do
      get root_url(subdomain: "hamburg")
      I18n.locale.should be(:de)
    end
  end

  describe "GET page with a different default locale" do
    before { Whitelabel.labels.first.stubs(default_locale: :en) }

    it "should have a different default locale" do
      get root_url(subdomain: "hamburg")
      I18n.locale.should be(:en)
    end
  end

  describe "GET page with a locale cookie" do
    # FIXME (ps) 03.09.2012 the cookies do not seem to play nice in request-tests!
    before { ActionDispatch::Request.any_instance.stubs(cookies: {locale: :en}) }

    it "should do something" do
      get root_url(subdomain: "hamburg")
      I18n.locale.should be(:en)
    end
  end

  describe "GET page with a locale param" do
    before { ActionDispatch::Request.any_instance.stubs(cookies: {locale: :fr}) }

    it "should set the requested locale over the cookie and default locale" do
      get root_url(subdomain: "hamburg", locale: :en)
      I18n.locale.should be(:en)
    end
  end
end

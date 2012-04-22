require 'spec_helper'

describe SessionsController do
  describe "GET :switch_locale" do
    it "should assign the locale" do
      expect { get(:switch_locale, locale: :en) }.to change(I18n, :locale).from(:de).to(:en)
    end
  end
end

require 'spec_helper'

describe WhitelabelTranslation do
  context "#tw" do
    it "should translate in scope of a whitelabel" do
      I18n.tw("title").should eql("Hamburg on Ruby")
    end
  end
end

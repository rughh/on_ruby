require "spec_helper"

describe "mobile/labels/index" do
  before do
    Whitelabel.label = nil
  end

  it "should render successfully" do
    render
  end
end

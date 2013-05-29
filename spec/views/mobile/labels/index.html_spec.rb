require "spec_helper"

describe "mobile/labels/index" do
  it "should render successfully" do
    Whitelabel.reset!
    render
  end
end

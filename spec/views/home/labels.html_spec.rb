require "spec_helper"

describe "home/labels" do
  before do
    Whitelabel.label = nil
  end

  it "should render successfully" do
    render
  end
end

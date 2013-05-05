require "spec_helper"

describe "labels/index" do
  before do
    Whitelabel.label = nil
  end

  it "should render successfully" do
    render
  end
end

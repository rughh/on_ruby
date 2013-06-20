require "spec_helper"

describe "mobile/settings/index" do
  let(:user) { build(:user) }

  it "should render successfully" do
    view.stubs(signed_in?: false)
    render
  end
end

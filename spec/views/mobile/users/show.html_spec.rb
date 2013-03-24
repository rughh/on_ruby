require "spec_helper"

describe "mobile/users/show" do
  let(:user) { build(:user) }

  it "should render successfully" do
    view.stubs(user: user)
    render
  end
end

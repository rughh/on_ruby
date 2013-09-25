require "spec_helper"

describe "mobile/users/show" do
  let(:user) { build(:user) }

  it "should render successfully" do
    view.stub(user: user)
    render
  end
end

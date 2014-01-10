require "spec_helper"

describe "users/show" do
  let(:user) { build(:user) }

  it "should render successfully" do
    view.stub(current_user: user, user: user)

    render
  end
end

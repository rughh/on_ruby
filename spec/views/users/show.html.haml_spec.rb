require "spec_helper"

describe "users/show" do

  let(:user) { build(:user) }

  it "should render successfully" do
    view.stubs(current_user: user, user: user)
    render
  end

end

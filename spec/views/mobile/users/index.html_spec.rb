require "spec_helper"

describe "mobile/users/index" do
  let(:users) { [build(:user)] }

  it "should render successfully" do
    view.stubs(users: users)
    render
  end
end

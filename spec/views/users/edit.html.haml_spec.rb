require "spec_helper"

describe "/users/edit" do

  it "should render successfully" do
    view.stubs(user: Factory(:user))
    render
  end

end

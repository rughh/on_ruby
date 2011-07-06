require "spec_helper"

describe "/events/show" do

  it "should render successfully" do
    view.stubs(current_user: Factory(:user), can?: false, event: Factory(:event))
    render
  end

end

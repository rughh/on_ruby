require "spec_helper"

describe "users/show.html.haml" do

  let(:user) { Factory(:user) }

  it "should render successfully" do
    view.stubs(current_user: user, user: user)
    render
  end

end

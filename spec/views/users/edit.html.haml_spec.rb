require "spec_helper"

describe "users/edit.html.haml" do

  let(:user) { Factory.build(:user) }

  it "should render successfully" do
    view.stubs(current_user: user, user: user)
    render
  end

end

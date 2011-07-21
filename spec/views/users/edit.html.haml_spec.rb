require "spec_helper"

describe "/users/edit" do
  
  before do
    @user = Factory(:user)
  end

  it "should render successfully" do
    view.stubs(current_user: @user, user: @user)
    render
  end

end

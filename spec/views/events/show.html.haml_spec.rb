require "spec_helper"

describe "/events/show" do

  it "should render successfully" do
    view.should_receive(:current_user).and_return(Factory(:user))
    assign :event, Factory(:event)
    render
  end

end

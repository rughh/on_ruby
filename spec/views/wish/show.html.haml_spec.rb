require "spec_helper"

describe "/wishes/show" do

  it "should render successfully" do
    view.stubs(wish: Factory(:wish), signed_in?: false)
    render
  end

end

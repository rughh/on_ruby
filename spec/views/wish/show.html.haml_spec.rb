require "spec_helper"

describe "wishes/show.html.haml" do

  let(:wish) { Factory(:wish) }

  it "should render successfully" do
    view.stubs(wish: wish, signed_in?: false)
    render
  end

end

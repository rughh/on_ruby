require "spec_helper"

describe "locations/index.html.haml" do

  let(:locations) { [Factory.build(:location)] }

  it "should render successfully" do
    view.stubs(locations: locations)
    render
  end

end

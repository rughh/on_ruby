require "spec_helper"

describe "locations/show" do

  let(:location) { build(:location) }

  it "should render successfully" do
    view.stubs(current_location: location)
    render
  end

end

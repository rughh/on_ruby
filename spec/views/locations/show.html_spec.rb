require "spec_helper"

describe "locations/show" do

  let(:location) { build(:location) }

  it "should render successfully" do
    view.stub(current_location: location)
    render
  end

end

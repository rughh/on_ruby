require "spec_helper"

describe "locations/index" do

  let(:locations) { [build(:location)] }

  it "should render successfully" do
    view.stub(locations: locations)
    render
  end

end

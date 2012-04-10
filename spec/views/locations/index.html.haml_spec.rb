require "spec_helper"

describe "locations/index" do

  let(:locations) { [FactoryGirl.build(:location)] }

  it "should render successfully" do
    view.stubs(locations: locations)
    render
  end

end

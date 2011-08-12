require "spec_helper"

describe "locations/index.html.haml" do

  let(:locations) { [Factory(:location)] }

  it "should render successfully" do
    view.stubs(locations: locations, will_paginate: '')
    render
  end

end

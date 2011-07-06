require "spec_helper"

describe "/events/index" do

  it "should render successfully" do
    view.stubs(will_paginate: Factory(:event), upcoming_events: [Factory(:event)], events: 3.times.map { Factory(:event) })
    render
  end

end

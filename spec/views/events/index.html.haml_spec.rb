require "spec_helper"

describe "/events/index" do

  it "should render successfully" do
    view.expects(:will_paginate).returns(Factory(:event))
    assign :events, 3.times.map { Factory(:event) }
    assign :upcoming_events, [Factory(:event)]
    render
  end

end

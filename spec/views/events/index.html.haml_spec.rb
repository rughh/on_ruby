require "spec_helper"

describe "/events/index" do

  it "should render successfully" do
    view.should_receive(:will_paginate).and_return(Factory(:event))
    assign :events, 3.times.map { Factory(:event) }
    render
  end

end

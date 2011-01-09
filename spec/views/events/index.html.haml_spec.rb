require "spec_helper"

describe "/events/index" do

  it "should render successfully" do
    view.should_receive(:will_paginate).and_return(Factory(:event))
    view.should_receive(:can?).any_number_of_times.and_return(false)
    assign :events, 3.times.map { Factory(:event) }
    render
  end

end

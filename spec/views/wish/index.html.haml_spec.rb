require "spec_helper"

describe "/wishes/index" do

  it "should render successfully" do
    view.should_receive(:simple_form_for).any_number_of_times.and_return('')
    view.should_receive(:will_paginate).and_return(Factory(:wish))
    assign :wishes, 3.times.map { Factory(:wish) }
    assign :wish, Factory(:wish)
    render
  end

end

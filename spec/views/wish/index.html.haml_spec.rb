require "spec_helper"

describe "/wishes/index" do

  it "should render successfully" do
    view.stubs(:simple_form_for => '')
    view.expects(:will_paginate).returns(Factory(:wish))
    assign :wishes, 3.times.map { Factory(:wish) }
    assign :wish, Factory(:wish)
    render
  end

end

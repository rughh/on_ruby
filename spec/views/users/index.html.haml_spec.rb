require "spec_helper"

describe "/users/index" do

  it "should render successfully" do
    view.expects(:will_paginate).returns(Factory(:user))
    assign :users, 3.times.map { Factory(:user) }
    render
  end

end

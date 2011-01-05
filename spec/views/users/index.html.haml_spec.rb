require "spec_helper"

describe "/users/index" do

  it "should render successfully" do
    view.should_receive(:will_paginate).and_return(Factory(:user))
    assign :users, 3.times.map { Factory(:user) }
    render
  end

end

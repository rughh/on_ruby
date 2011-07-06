require "spec_helper"

describe "/users/index" do
  
  before(:each) do
    view.stubs(:tweets => [])
  end

  it "should render successfully" do
    view.stubs(will_paginate: Factory(:user), users: 3.times.map { Factory(:user) })
    render
  end

end

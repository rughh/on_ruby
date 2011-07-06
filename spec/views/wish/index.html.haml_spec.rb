require "spec_helper"

describe "/wishes/index" do

  it "should render successfully" do
    view.stubs(will_paginate: Factory(:wish), wishes: 3.times.map { Factory(:wish) }, wish: Factory(:wish), signed_in?: true)
    render
  end

end

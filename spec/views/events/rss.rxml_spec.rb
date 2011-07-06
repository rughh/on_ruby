require "spec_helper"

describe "/events/rss" do

  it "should render successfully" do
    view.stubs(events: 3.times.map { Factory :event })
    render
  end

end

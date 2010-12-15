require "spec_helper"

describe "/events/rss" do

  it "should render successfully" do
    assign :events, 3.times.map { Factory :event }
    render
  end

end

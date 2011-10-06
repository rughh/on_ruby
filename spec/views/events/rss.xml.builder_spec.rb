require "spec_helper"

describe "events/rss.xml.builder" do

  let(:events) { 3.times.map { Factory(:event) } }

  it "should render successfully" do
    view.stubs(events: events)
    render
  end

end

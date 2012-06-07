require "spec_helper"

describe "events/rss" do

  let(:events) { 3.times.map { create(:event) } }

  it "should render successfully" do
    view.stubs(events: events)
    render
  end

end

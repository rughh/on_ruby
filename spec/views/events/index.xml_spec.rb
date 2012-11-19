require "spec_helper"

describe "events/index" do

  let(:events) { 3.times.map { build(:event, id: 123) } }

  it "should render successfully" do
    view.stubs(events: events)
    render
  end

end

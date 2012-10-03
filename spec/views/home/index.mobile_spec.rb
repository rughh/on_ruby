require "spec_helper"

describe "home/index" do
  let(:event) { build(:event) }

  it "should render successfully" do
    view.stubs(current_event: event, events: [event])
    render
  end
end

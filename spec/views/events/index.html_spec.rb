require "spec_helper"

describe "events/index" do
  let(:event) { build(:event, id: 123) }

  it "should render successfully" do
    view.stub(events: paged(event))

    render
  end
end

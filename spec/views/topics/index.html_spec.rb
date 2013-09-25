require "spec_helper"

describe "topics/index" do

  let(:event) { build(:event) }

  it "should render successfully" do
    view.stub(events: paged(event))
    render
  end
end

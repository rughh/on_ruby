require "spec_helper"

describe "mobile/topics/show" do
  let(:topic) { build(:topic) }

  it "should render successfully" do
    view.stubs(topic: topic)
    render
  end
end

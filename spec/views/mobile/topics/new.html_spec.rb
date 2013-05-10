require "spec_helper"

describe "mobile/topics/new" do
  let(:topic) { Topic.new }

  it "should render successfully" do
    view.stubs(topic: topic)
    render
  end
end

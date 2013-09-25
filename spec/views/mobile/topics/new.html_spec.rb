require "spec_helper"

describe "mobile/topics/new" do
  let(:topic) { Topic.new }

  it "should render successfully" do
    view.stub(topic: topic)
    render
  end
end

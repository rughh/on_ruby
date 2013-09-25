require "spec_helper"

describe "topics/new" do

  let(:topic) { Topic.new }

  it "should render successfully" do
    view.stub(topic: topic, undone_topics: [topic])
    render
  end
end

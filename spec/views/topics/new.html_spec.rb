require "spec_helper"

describe "topics/new" do
  let(:topic) { Topic.new }

  it "should render successfully" do
    view.stub(signed_in?: true, topic: topic, undone_topics: [topic])
    render
  end
end

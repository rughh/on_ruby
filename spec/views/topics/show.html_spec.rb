require "spec_helper"

describe "topics/show" do
  let(:topic) { build(:topic) }

  it "should render successfully" do
    allow(view).to receive_messages(topic: topic, signed_in?: false, likes: '</>')

    render
  end
end

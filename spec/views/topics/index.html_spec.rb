require "spec_helper"

describe "topics/index" do

  let(:topic) { build(:topic) }

  it "should render successfully" do
    view.stubs(undone_topics: [topic], done_topics: [topic])
    render
  end
end

require "spec_helper"

describe "mobile/topics/index" do
  let(:topics) { [build(:topic)] }

  it "should render successfully" do
    view.stubs(undone_topics: topics, done_topics: topics)
    render
  end
end

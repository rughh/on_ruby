require "spec_helper"

describe "topics/edit" do
  let(:topic) { build(:topic) }
  let(:user) { build(:user) }

  it "should render successfully" do
    view.stub(current_user: user, topic: topic, undone_topics: [topic])
    render
  end

end

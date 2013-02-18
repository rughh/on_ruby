require "spec_helper"

describe "topics/show" do

  let(:topic) { build(:topic) }

  it "should render successfully" do
    view.stubs(topic: topic, signed_in?: false)
    render
  end
end

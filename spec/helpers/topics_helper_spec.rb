require 'spec_helper'

describe TopicsHelper do
  let(:topic) { build(:topic, id: 123) }

  context "#like_link" do
    it "disables the button if not signed-in" do
      helper.stub(signed_in?: false)
      helper.like_link(topic).should match('disable')
    end

    context "with logged-in user" do
      let(:user) { build(:user) }

      before do
        helper.stub(signed_in?: true, current_user: user)
      end

      it "shows a button for liking a topic" do
        helper.like_link(topic).should match('gefällt mir')
      end
    end
  end
end

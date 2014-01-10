require 'spec_helper'

describe TopicsHelper do
  let(:topic) { build(:topic, id: 123) }

  context "#like_link" do
    it "disables the button if not signed-in" do
      helper.stub(signed_in?: false)

      expect(helper.like_link(topic)).to match('disable')
    end

    context "with logged-in user" do
      let(:user) { build(:user) }

      before do
        helper.stub(signed_in?: true, current_user: user)
      end

      it "shows a button for liking a topic" do
        expect(helper.like_link(topic)).to match('gefällt mir')
      end
    end
  end
end

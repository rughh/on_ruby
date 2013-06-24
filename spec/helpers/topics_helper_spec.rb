# encoding: utf-8
require 'spec_helper'

describe TopicsHelper do
  let(:topic) { build(:topic) }

  context "#like_link" do
    it "disables the button if not signed-in" do
      helper.stubs(signed_in?: false)
      helper.like_link(topic).should match('disable')
    end

    context "with logged-in user" do
      let(:user) { build(:user) }

      before do
        helper.stubs(signed_in?: true, current_user: user)
      end

      it "shows a button for liking a topic" do
        helper.like_link(topic).should match('gefällt mir')
      end
    end
  end
end

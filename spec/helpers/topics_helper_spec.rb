# typed: false
require 'spec_helper'

describe TopicsHelper do
  let(:topic) { build(:topic, id: 123) }

  context '#like_link' do
    context 'with logged-in user' do
      let(:user) { build(:user) }

      before do
        allow(helper).to receive_messages(signed_in?: true, current_user: user)
      end

      it 'shows a button for liking a topic' do
        expect(helper.like_link(topic)).to match('gefällt mir')
      end

      it 'shows a button for un-liking a topic' do
        create(:like, user: user, topic: topic)

        expect(helper.like_link(topic)).to match('gefällt nicht')
      end

      it 'shows an eidt button for the owner' do
        topic.update! user: user

        expect(helper.like_link(topic)).to match('bearbeiten')
      end
    end
  end
end

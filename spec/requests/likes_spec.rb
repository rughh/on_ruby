require 'spec_helper'

describe 'Likes', type: :request do
  let(:topic) { create(:topic) }

  describe 'POST /topics/:topic_id/likes' do
    it 'redirects anonymous visitors to the login' do
      expect { post topic_likes_path(topic) }.not_to change(Like, :count)

      expect(response).to redirect_to(login_path)
    end

    it 'creates a like for the signed-in user' do
      user = login_as(create(:user))

      expect { post topic_likes_path(topic) }.to change(Like, :count).by(1)
      expect(Like.order(:created_at).last).to have_attributes(user:, topic:)
      expect(response).to redirect_to(topic_path(topic))
    end

    it 'does not create a second like for the same topic' do
      user = login_as(create(:user))
      create(:like, user:, topic:)

      expect { post topic_likes_path(topic) }.not_to change(Like, :count)
      expect(flash[:alert]).to eq(I18n.t('flash.double_liked'))
    end

    it 'does not create a like that fails to save' do
      login_as(create(:user))
      allow_any_instance_of(Like).to receive(:save).and_return(false)

      expect { post topic_likes_path(topic) }.not_to change(Like, :count)
    end
  end

  describe 'DELETE /topics/:topic_id/likes/:id' do
    it 'redirects anonymous visitors to the login' do
      like = create(:like, topic:)

      expect { delete topic_like_path(topic, like) }.not_to change(Like, :count)
      expect(response).to redirect_to(login_path)
    end

    it 'deletes the like for the user who owns it' do
      user = login_as(create(:user))
      like = create(:like, user:, topic:)

      expect { delete topic_like_path(topic, like) }.to change(Like, :count).by(-1)
      expect(response).to redirect_to(topic_path(topic))
    end

    it 'does not delete a like owned by another user' do
      login_as(create(:user))
      like = create(:like, topic:)

      expect { delete topic_like_path(topic, like) }.not_to change(Like, :count)
    end
  end
end

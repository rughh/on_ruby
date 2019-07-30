# typed: false
require 'spec_helper'

describe LikesController do
  let(:user) { build(:user) }

  context 'POST :create' do
    let!(:topic) { create(:topic) }
    let!(:data) { { like: attributes_for(:like), topic_id: topic.id } }

    it 'authenticates the action' do
      post(:create, params: data)
      expect(response).to redirect_to(login_path)
    end

    context 'with logged-in user' do
      before do
        allow(controller).to receive_messages(current_user: user)
      end

      it 'creates a like for logged-in user' do
        expect {
          post(:create, params: data)
        }.to change(Like, :count).by(1)
        expect(controller.like.user).to eql(user)
      end

      it 'does not create a like twice' do
        allow_any_instance_of(Topic).to receive_messages(already_liked?: true)

        expect {
          post(:create, params: data)
        }.to change(Like, :count).by(0)
      end

      it 'validetes likes' do
        allow_any_instance_of(Like).to receive_messages(save: false)

        post(:create, params: data)
        expect(flash[:alert]).to be_blank
      end
    end
  end

  context 'POST :destroy' do
    let!(:like) { create(:like, user: user) }
    let!(:topic) { create(:topic) }

    it 'authenticates the action' do
      delete(:destroy, params: { topic_id: topic.id, id: like.id })
      expect(response).to redirect_to(login_path)
    end

    context 'with logged-in user' do
      before do
        allow(controller).to receive_messages(current_user: user)
      end

      it 'deletes a like for logged-in user' do
        topic.likes << like

        expect {
          delete(:destroy, params: { topic_id: topic.id, id: like.id })
        }.to change(Like, :count).by(-1)
        expect(response).to redirect_to(topic_path(topic))
      end

      it 'does not delete likes for other users' do
        allow_any_instance_of(Topic).to receive_messages(already_liked?: false)

        expect {
          delete(:destroy, params: { topic_id: topic.id, id: like.id })
        }.to change(Like, :count).by(0)
        expect(flash[:alert]).to be_blank
      end
    end
  end
end

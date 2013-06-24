require 'spec_helper'

describe LikesController do
  let(:user) { build(:user) }

  context "POST :create" do
    let!(:topic) { create(:topic) }
    let!(:data) { {:like => attributes_for(:like), :topic_id => topic.id} }

    it "authenticates the action" do
      post(:create, data)
      response.should redirect_to(root_path)
    end

    context "with logged-in user" do
      before do
        controller.stubs(:current_user => user)
      end

      it "creates a like for logged-in user" do
        expect { post(:create, data) }.to change(Like, :count).by(1)
        controller.like.user.should eql(user)
      end

      it "does not create a like twice" do
        Topic.any_instance.stubs(already_liked?: true)
        expect { post(:create, data) }.to change(Like, :count).by(0)
      end

      it "validetes likes" do
        Like.any_instance.stubs(save: false)
        post(:create, data)
        flash[:alert].should_not be_nil
      end
    end
  end

  context "POST :destroy" do
    let!(:like) { create(:like, user: user) }
    let!(:topic) { create(:topic) }

    it "authenticates the action" do
      delete(:destroy, topic_id: topic.id, id: like.id)
      response.should redirect_to(root_path)
    end

    context "with logged-in user" do
      before do
        controller.stubs(:current_user => user)
      end

      it "deletes a like for logged-in user" do
        topic.likes << like
        expect { delete(:destroy, topic_id: topic.id, id: like.id) }.to change(Like, :count).by(-1)
        response.should redirect_to(topic_path(topic))
      end

      it "does not delete likes for other users" do
        Topic.any_instance.stubs(already_liked?: false)
        expect { delete(:destroy, topic_id: topic.id, id: like.id) }.to change(Like, :count).by(0)
        flash[:alert].should_not be_nil
      end
    end
  end
end

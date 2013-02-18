require 'spec_helper'

describe LikesController do

  let(:user) { create(:user) }

  before { set_subdomain }

  describe "POST :create" do
    let(:topic) { create(:topic) }
    let(:data) { {:like => attributes_for(:like), :topic_id => topic.id} }

    it "should create a like for logged-in user" do
      @controller.stubs(:current_user => user)
      expect { post(:create, data) }.to change(Like, :count).by(1)
      controller.like.user.should eql(user)
    end

    it "should not create a like if not signed in" do
      expect { post(:create, data) }.to change(Like, :count).by(0)
      response.should redirect_to(auth_path)
    end
  end

  describe "POST :delete" do
    let!(:like) { create(:like, user: user) }
    let(:topic) { create(:topic, likes: [like]) }

    it "should delete a like for logged-in user" do
      @controller.stubs(:current_user => user)
      expect { delete(:destroy, topic_id: topic.id, id: like.id) }.to change(Like, :count).by(-1)
      controller.like.user.should eql(user)
      response.should redirect_to(topic_path(topic))
    end
  end
end

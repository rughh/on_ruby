require 'spec_helper'

describe LikesController do

  let(:user) { create(:user) }
  let(:topic) { create(:topic) }
  let(:data) { {:like => attributes_for(:like), :topic_id => topic.id} }

  before { set_subdomain }

  describe "POST :create" do
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
end

require 'spec_helper'

describe TopicsController do
  context "GET :show" do
    let(:topic) { create(:topic) }

    it "should assign members" do
      get :show, id: topic.id

      controller.topic.should eql(topic)
      response.should render_template(:show)
    end
  end

  context "POST :create" do
    let(:user) { create(:user) }
    let(:topic_data) { attributes_for(:topic) }

    it "should create a topic for logged-in user" do
      @controller.stubs(current_user: user)
      expect do
        post(:create, topic: topic_data)
      end.to change(Topic, :count).by(1)
      controller.topic.user.should eql(user)
      flash[:notice].should_not be_nil
    end

    it "should not create a topic if not signed in" do
      expect { post(:create, topic: topic_data) }.to change(Topic, :count).by(0)
      response.should redirect_to(auth_path)
    end
  end

  context "POST :update" do
    let(:user) { create(:user) }
    let(:topic) { create(:topic, user: user) }

    it "should update a topic for logged-in user" do
      @controller.stubs(current_user: user)
      put(:update, id: topic, topic: {name: 'blupp'})

      controller.topic.name.should eql('blupp')
      flash[:notice].should_not be_nil
    end

    it "should not update a topic if not signed in" do
      put(:update, id: topic.id, topic: attributes_for(:topic))
      response.should redirect_to(auth_path)
    end
  end
end

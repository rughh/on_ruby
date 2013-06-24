require 'spec_helper'

describe TopicsController do
  context "GET :show" do
    let(:topic) { create(:topic) }

    it "renders the action" do
      get :show, id: topic.id

      controller.topic.should eql(topic)
      response.should render_template(:show)
    end
  end

  context "GET :new" do
    let(:user) { build(:user) }

    it "renders the action" do
      controller.stubs(current_user: user)
      get :new

      controller.topic.should_not be_persisted
      response.should render_template(:new)
    end
  end

  context "GET :edit" do
    let(:user) { create(:user) }
    let(:topic) { create(:topic, user: user) }

    it "renders the action" do
      controller.stubs(current_user: user)
      get :edit, id: topic.id

      controller.topic.should be_persisted
      response.should render_template(:edit)
    end
  end

  context "POST :create" do
    let(:user) { create(:user) }
    let(:topic_data) { attributes_for(:topic) }

    it "should create a topic for logged-in user" do
      controller.stubs(current_user: user)
      expect { post(:create, topic: topic_data) }.to change(Topic, :count).by(1)
      controller.topic.user.should eql(user)
      flash[:notice].should_not be_nil
    end

    it "should not create a topic if not signed in" do
      expect { post(:create, topic: topic_data) }.to change(Topic, :count).by(0)
      response.should redirect_to(root_path)
    end
  end

  context "POST :update" do
    it "authenticates the action" do
      put(:update, id: 123, topic: attributes_for(:topic))
      response.should redirect_to(root_path)
      flash[:alert].should_not be_nil
    end

    context "with logged-in user" do
      let(:user) { create(:user) }
      let(:other_user) { create(:user) }
      let(:topic) { create(:topic, user: user) }

      before do
        controller.stubs(current_user: user)
      end

      it "updates a topic" do
        put(:update, id: topic, topic: {name: 'blupp'})

        controller.topic.name.should eql('blupp')
        flash[:notice].should_not be_nil
      end

      it "does not update a topic for a different user" do
        controller.stubs(current_user: other_user)
        put(:update, id: topic, topic: {name: 'blupp'})

        expect(response).to redirect_to(root_path)
        flash[:alert].should_not be_nil
      end
    end
  end
end

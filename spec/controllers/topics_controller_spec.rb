require 'spec_helper'

describe TopicsController do

  # def mock_topic(stubs={})
  #   (@mock_topic ||= mock_model(Topic).as_null_object).tap do |topic|
  #     topic.stub(stubs) unless stubs.empty?
  #   end
  # end
  # 
  # describe "GET index" do
  #   it "assigns all topics as @topics" do
  #     Topic.stub(:all) { [mock_topic] }
  #     get :index
  #     assigns(:topics).should eq([mock_topic])
  #   end
  # end
  # 
  # describe "GET show" do
  #   it "assigns the requested topic as @topic" do
  #     Topic.stub(:find).with("37") { mock_topic }
  #     get :show, :id => "37"
  #     assigns(:topic).should be(mock_topic)
  #   end
  # end
  # 
  # describe "GET new" do
  #   it "assigns a new topic as @topic" do
  #     Topic.stub(:new) { mock_topic }
  #     get :new
  #     assigns(:topic).should be(mock_topic)
  #   end
  # end
  # 
  # describe "GET edit" do
  #   it "assigns the requested topic as @topic" do
  #     Topic.stub(:find).with("37") { mock_topic }
  #     get :edit, :id => "37"
  #     assigns(:topic).should be(mock_topic)
  #   end
  # end
  # 
  # describe "POST create" do
  # 
  #   describe "with valid params" do
  #     it "assigns a newly created topic as @topic" do
  #       Topic.stub(:new).with({'these' => 'params'}) { mock_topic(:save => true) }
  #       post :create, :topic => {'these' => 'params'}
  #       assigns(:topic).should be(mock_topic)
  #     end
  # 
  #     it "redirects to the created topic" do
  #       Topic.stub(:new) { mock_topic(:save => true) }
  #       post :create, :topic => {}
  #       response.should redirect_to(topic_url(mock_topic))
  #     end
  #   end
  # 
  #   describe "with invalid params" do
  #     it "assigns a newly created but unsaved topic as @topic" do
  #       Topic.stub(:new).with({'these' => 'params'}) { mock_topic(:save => false) }
  #       post :create, :topic => {'these' => 'params'}
  #       assigns(:topic).should be(mock_topic)
  #     end
  # 
  #     it "re-renders the 'new' template" do
  #       Topic.stub(:new) { mock_topic(:save => false) }
  #       post :create, :topic => {}
  #       response.should render_template("new")
  #     end
  #   end
  # 
  # end
  # 
  # describe "PUT update" do
  # 
  #   describe "with valid params" do
  #     it "updates the requested topic" do
  #       Topic.should_receive(:find).with("37") { mock_topic }
  #       mock_topic.should_receive(:update_attributes).with({'these' => 'params'})
  #       put :update, :id => "37", :topic => {'these' => 'params'}
  #     end
  # 
  #     it "assigns the requested topic as @topic" do
  #       Topic.stub(:find) { mock_topic(:update_attributes => true) }
  #       put :update, :id => "1"
  #       assigns(:topic).should be(mock_topic)
  #     end
  # 
  #     it "redirects to the topic" do
  #       Topic.stub(:find) { mock_topic(:update_attributes => true) }
  #       put :update, :id => "1"
  #       response.should redirect_to(topic_url(mock_topic))
  #     end
  #   end
  # 
  #   describe "with invalid params" do
  #     it "assigns the topic as @topic" do
  #       Topic.stub(:find) { mock_topic(:update_attributes => false) }
  #       put :update, :id => "1"
  #       assigns(:topic).should be(mock_topic)
  #     end
  # 
  #     it "re-renders the 'edit' template" do
  #       Topic.stub(:find) { mock_topic(:update_attributes => false) }
  #       put :update, :id => "1"
  #       response.should render_template("edit")
  #     end
  #   end
  # 
  # end
  # 
  # describe "DELETE destroy" do
  #   it "destroys the requested topic" do
  #     Topic.should_receive(:find).with("37") { mock_topic }
  #     mock_topic.should_receive(:destroy)
  #     delete :destroy, :id => "37"
  #   end
  # 
  #   it "redirects to the topics list" do
  #     Topic.stub(:find) { mock_topic }
  #     delete :destroy, :id => "1"
  #     response.should redirect_to(topics_url)
  #   end
  # end

end

require 'spec_helper'

describe ParticipantsController do

  # def mock_participant(stubs={})
  #   (@mock_participant ||= mock_model(Participant).as_null_object).tap do |participant|
  #     participant.stub(stubs) unless stubs.empty?
  #   end
  # end
  # 
  # describe "GET index" do
  #   it "assigns all participants as @participants" do
  #     Participant.stub(:all) { [mock_participant] }
  #     get :index
  #     assigns(:participants).should eq([mock_participant])
  #   end
  # end
  # 
  # describe "GET show" do
  #   it "assigns the requested participant as @participant" do
  #     Participant.stub(:find).with("37") { mock_participant }
  #     get :show, :id => "37"
  #     assigns(:participant).should be(mock_participant)
  #   end
  # end
  # 
  # describe "GET new" do
  #   it "assigns a new participant as @participant" do
  #     Participant.stub(:new) { mock_participant }
  #     get :new
  #     assigns(:participant).should be(mock_participant)
  #   end
  # end
  # 
  # describe "GET edit" do
  #   it "assigns the requested participant as @participant" do
  #     Participant.stub(:find).with("37") { mock_participant }
  #     get :edit, :id => "37"
  #     assigns(:participant).should be(mock_participant)
  #   end
  # end
  # 
  # describe "POST create" do
  # 
  #   describe "with valid params" do
  #     it "assigns a newly created participant as @participant" do
  #       Participant.stub(:new).with({'these' => 'params'}) { mock_participant(:save => true) }
  #       post :create, :participant => {'these' => 'params'}
  #       assigns(:participant).should be(mock_participant)
  #     end
  # 
  #     it "redirects to the created participant" do
  #       Participant.stub(:new) { mock_participant(:save => true) }
  #       post :create, :participant => {}
  #       response.should redirect_to(participant_url(mock_participant))
  #     end
  #   end
  # 
  #   describe "with invalid params" do
  #     it "assigns a newly created but unsaved participant as @participant" do
  #       Participant.stub(:new).with({'these' => 'params'}) { mock_participant(:save => false) }
  #       post :create, :participant => {'these' => 'params'}
  #       assigns(:participant).should be(mock_participant)
  #     end
  # 
  #     it "re-renders the 'new' template" do
  #       Participant.stub(:new) { mock_participant(:save => false) }
  #       post :create, :participant => {}
  #       response.should render_template("new")
  #     end
  #   end
  # 
  # end
  # 
  # describe "PUT update" do
  # 
  #   describe "with valid params" do
  #     it "updates the requested participant" do
  #       Participant.should_receive(:find).with("37") { mock_participant }
  #       mock_participant.should_receive(:update_attributes).with({'these' => 'params'})
  #       put :update, :id => "37", :participant => {'these' => 'params'}
  #     end
  # 
  #     it "assigns the requested participant as @participant" do
  #       Participant.stub(:find) { mock_participant(:update_attributes => true) }
  #       put :update, :id => "1"
  #       assigns(:participant).should be(mock_participant)
  #     end
  # 
  #     it "redirects to the participant" do
  #       Participant.stub(:find) { mock_participant(:update_attributes => true) }
  #       put :update, :id => "1"
  #       response.should redirect_to(participant_url(mock_participant))
  #     end
  #   end
  # 
  #   describe "with invalid params" do
  #     it "assigns the participant as @participant" do
  #       Participant.stub(:find) { mock_participant(:update_attributes => false) }
  #       put :update, :id => "1"
  #       assigns(:participant).should be(mock_participant)
  #     end
  # 
  #     it "re-renders the 'edit' template" do
  #       Participant.stub(:find) { mock_participant(:update_attributes => false) }
  #       put :update, :id => "1"
  #       response.should render_template("edit")
  #     end
  #   end
  # 
  # end
  # 
  # describe "DELETE destroy" do
  #   it "destroys the requested participant" do
  #     Participant.should_receive(:find).with("37") { mock_participant }
  #     mock_participant.should_receive(:destroy)
  #     delete :destroy, :id => "37"
  #   end
  # 
  #   it "redirects to the participants list" do
  #     Participant.stub(:find) { mock_participant }
  #     delete :destroy, :id => "1"
  #     response.should redirect_to(participants_url)
  #   end
  # end

end

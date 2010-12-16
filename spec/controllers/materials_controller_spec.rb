require 'spec_helper'

include SpecHelper

describe MaterialsController do

  def mock_material(stubs={})
    (@mock_material ||= mock_model(Material).as_null_object).tap do |material|
      material.stub(stubs) unless stubs.empty?
    end
  end
  
  before(:each) do
    authorize_admin
    @event = Factory(:event)
  end
  
  describe "POST create with admin_user" do
  
    describe "with valid params" do
      it "creates a new material and redirects to parent with notice" do
        Material.stub(:new) { mock_material(:save => true) }
        post :create, :event_id => @event.id, :material => {}
        response.should redirect_to(@event)
        flash[:notice].should_not be(nil)
      end
    end
  
    describe "with invalid params" do
      it "redirects to parent with alert" do
        post :create, :event_id => @event.id, :material => {}
        response.should redirect_to(@event)
        flash[:alert].should_not be(nil)
      end
    end
  
  end

  # describe "DELETE destroy" do
  #   it "destroys the requested material" do
  #     Material.should_receive(:find).with("37") { mock_material }
  #     mock_material.should_receive(:destroy)
  #     delete :destroy, :id => "37"
  #   end
  # 
  #   it "redirects to the materials list" do
  #     Material.stub(:find) { mock_material }
  #     delete :destroy, :id => "1"
  #     response.should redirect_to(materials_url)
  #   end
  # end

end

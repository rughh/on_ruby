require 'spec_helper'

describe MaterialsController do

  # def mock_material(stubs={})
  #   (@mock_material ||= mock_model(Material).as_null_object).tap do |material|
  #     material.stub(stubs) unless stubs.empty?
  #   end
  # end
  # 
  # describe "GET index" do
  #   it "assigns all materials as @materials" do
  #     Material.stub(:all) { [mock_material] }
  #     get :index
  #     assigns(:materials).should eq([mock_material])
  #   end
  # end
  # 
  # describe "GET show" do
  #   it "assigns the requested material as @material" do
  #     Material.stub(:find).with("37") { mock_material }
  #     get :show, :id => "37"
  #     assigns(:material).should be(mock_material)
  #   end
  # end
  # 
  # describe "GET new" do
  #   it "assigns a new material as @material" do
  #     Material.stub(:new) { mock_material }
  #     get :new
  #     assigns(:material).should be(mock_material)
  #   end
  # end
  # 
  # describe "GET edit" do
  #   it "assigns the requested material as @material" do
  #     Material.stub(:find).with("37") { mock_material }
  #     get :edit, :id => "37"
  #     assigns(:material).should be(mock_material)
  #   end
  # end
  # 
  # describe "POST create" do
  # 
  #   describe "with valid params" do
  #     it "assigns a newly created material as @material" do
  #       Material.stub(:new).with({'these' => 'params'}) { mock_material(:save => true) }
  #       post :create, :material => {'these' => 'params'}
  #       assigns(:material).should be(mock_material)
  #     end
  # 
  #     it "redirects to the created material" do
  #       Material.stub(:new) { mock_material(:save => true) }
  #       post :create, :material => {}
  #       response.should redirect_to(material_url(mock_material))
  #     end
  #   end
  # 
  #   describe "with invalid params" do
  #     it "assigns a newly created but unsaved material as @material" do
  #       Material.stub(:new).with({'these' => 'params'}) { mock_material(:save => false) }
  #       post :create, :material => {'these' => 'params'}
  #       assigns(:material).should be(mock_material)
  #     end
  # 
  #     it "re-renders the 'new' template" do
  #       Material.stub(:new) { mock_material(:save => false) }
  #       post :create, :material => {}
  #       response.should render_template("new")
  #     end
  #   end
  # 
  # end
  # 
  # describe "PUT update" do
  # 
  #   describe "with valid params" do
  #     it "updates the requested material" do
  #       Material.should_receive(:find).with("37") { mock_material }
  #       mock_material.should_receive(:update_attributes).with({'these' => 'params'})
  #       put :update, :id => "37", :material => {'these' => 'params'}
  #     end
  # 
  #     it "assigns the requested material as @material" do
  #       Material.stub(:find) { mock_material(:update_attributes => true) }
  #       put :update, :id => "1"
  #       assigns(:material).should be(mock_material)
  #     end
  # 
  #     it "redirects to the material" do
  #       Material.stub(:find) { mock_material(:update_attributes => true) }
  #       put :update, :id => "1"
  #       response.should redirect_to(material_url(mock_material))
  #     end
  #   end
  # 
  #   describe "with invalid params" do
  #     it "assigns the material as @material" do
  #       Material.stub(:find) { mock_material(:update_attributes => false) }
  #       put :update, :id => "1"
  #       assigns(:material).should be(mock_material)
  #     end
  # 
  #     it "re-renders the 'edit' template" do
  #       Material.stub(:find) { mock_material(:update_attributes => false) }
  #       put :update, :id => "1"
  #       response.should render_template("edit")
  #     end
  #   end
  # 
  # end
  # 
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

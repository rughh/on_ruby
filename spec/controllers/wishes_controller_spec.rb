require 'spec_helper'

include SpecHelper

describe WishesController do
  
  describe "GET :index" do
    before do
      @wish = Factory(:wish)
      get :index
    end
    
    it "should assign members" do
      assigns(:wishes).should eql([@wish])
      assigns(:wish).new_record?.should be_true
      response.should render_template(:index)
    end
  end
  
  describe "POST :create" do
    before do
      @user = Factory(:user)
    end
    
    it "should create a wish for logged-in user" do
      @controller.stub(:current_user => @user)
      expect { post(:create, {:wish => Factory.attributes_for(:wish)}) }.to change(Wish, :count).by(1)
      assigns(:wish).user.should eql(@user)
      flash[:notice].should_not be_nil
    end
    
    it "should not create a wish any user" do
      expect { post(:create, {:wish => Factory.attributes_for(:wish)}) }.to change(Wish, :count).by(0)
      flash[:alert].should_not be_nil
    end
  end

end

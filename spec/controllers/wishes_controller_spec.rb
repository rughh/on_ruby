require 'spec_helper'

include SpecHelper

describe WishesController do

  describe "GET :index" do
    before do
      @wish = Factory(:wish)
      get :index
    end

    it "should assign members" do
      controller.wishes.should eql([@wish])
      controller.wish.should be_new_record
      response.should render_template(:index)
    end
  end
  
  describe "GET :show" do
    before do
      @wish = Factory(:wish)
      get :show, :id => @wish.id
    end

    it "should assign members" do
      controller.wish.should eql(@wish)
      response.should render_template(:show)
    end
  end

  describe "POST :create" do
    before do
      @user = Factory(:user)
      Wish.any_instance.stubs(:publish => true)
    end

    it "should create a wish for logged-in user" do
      @controller.stubs(:current_user => @user)
      expect do
        expect do
          post(:create, {:wish => Factory.attributes_for(:wish)}) 
        end.to change(Vote, :count).by(1)
      end.to change(Wish, :count).by(1)
      controller.wish.user.should eql(@user)
      flash[:notice].should_not be_nil
    end

    it "should not create a wish if not signed in" do
      expect { post(:create, {:wish => Factory.attributes_for(:wish)}) }.to change(Wish, :count).by(0)
      response.should redirect_to(auth_path)
    end
  end

end

require 'spec_helper'

include SpecHelper

describe VotesController do
  
  describe "POST :create" do
    before do
      @user = Factory(:user)
      @wish = Factory(:wish)
      @data = {:vote => Factory.attributes_for(:vote), :wish_id => @wish.id}
    end
    
    it "should create a vote for logged-in user" do
      @controller.stub(:current_user => @user)
      expect { post(:create, @data) }.to change(Vote, :count).by(1)
      assigns(:vote).user.should eql(@user)
      flash[:notice].should_not be_nil
    end
    
    it "should not create a vote any user" do
      expect { post(:create, @data) }.to change(Vote, :count).by(0)
      flash[:alert].should_not be_nil
    end
  end

end

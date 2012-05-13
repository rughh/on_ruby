require 'spec_helper'

describe VotesController do

  let(:user) { FactoryGirl.create(:user) }
  let(:wish) { FactoryGirl.create(:wish) }
  let(:data) { {:vote => FactoryGirl.attributes_for(:vote), :wish_id => wish.id} }

  before { set_subdomain }

  describe "POST :create" do
    it "should create a vote for logged-in user" do
      @controller.stubs(:current_user => user)
      expect { post(:create, data) }.to change(Vote, :count).by(1)
      controller.vote.user.should eql(user)
      flash[:notice].should_not be_nil
    end

    it "should not create a vote if not signed in" do
      expect { post(:create, data) }.to change(Vote, :count).by(0)
      response.should redirect_to(auth_path)
    end
  end

end

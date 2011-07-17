require 'spec_helper'

describe UsersController do

  describe "PUT :update" do
    before do
      @user = Factory(:user)
      @data = {id: @user.id, user: { github: 'testo', freelancer: true, available: true }}
      request.env["HTTP_REFERER"] = root_url
    end

    it "should update the github attribute of a user" do
      @controller.stubs(current_user: @user)
      put :update, @data
      controller.user.tap do |user|
        user.github.should eql('testo')
        user.freelancer.should be_true
        user.available.should be_true
      end
      response.should redirect_to(:back)
    end

    it "should not update injected properties" do
      @controller.stubs(current_user: @user)
      @data[:user][:nickname] = 'not_allowed_property'
      put :update, @data
      controller.user.nickname.should eql(@user.nickname)
    end

    it "should update nothing for wrong user" do
      put :update, @data
      flash[:alert].should_not be_nil
    end
  end

end

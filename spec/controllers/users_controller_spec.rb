require 'spec_helper'

describe UsersController do
  let(:user) { create(:user) }
  let(:data) { {id: user.id, user: { github: 'testo', freelancer: true, available: true }} }
  let(:unallowed_data) { data.merge({:user => {:nickname => 'not_allowed_property'}}) }

  before { set_subdomain }

  context "GET :show" do
    render_views

    it "rescues from not found" do
      get :show, id: "unknown"
      response.status.should eql(404)
    end
  end

  context "GET :edit" do
    it "should show alert for wrong user" do
      get :edit, id: user.id
      flash[:alert].should_not be_nil
      response.should redirect_to(root_url)
    end
  end

  context "DELETE :destroy" do
    context "removing" do
      let(:user) { create(:user, authorizations: [create(:authorization)]) }
      let(:event) { create(:event) }

      it "should delete a user and logout" do
        @controller.stubs(current_user: user)
        expect do
          expect do
            delete :destroy, id: user.id
          end.to change(User, :count).by(-1)
        end.to change(Authorization, :count).by(-1)

        flash[:notice].should_not be_nil
        response.should redirect_to(destroy_session_url)
      end

      it "should not delete an organizer" do
        @controller.stubs(current_user: event.user)
        expect do
          delete :destroy, id: event.user.id
        end.to change(User, :count).by(0)

        flash[:alert].should_not be_nil
        response.should redirect_to(edit_user_url(event.user))
      end
    end
  end

  context "PUT :update" do
    before { set_referer }

    it "should update the github attribute of a user" do
      @controller.stubs(current_user: user)
      put :update, data
      controller.user.tap do |user|
        user.github.should eql('testo')
        user.freelancer.should be_true
        user.available.should be_true
      end
      response.should redirect_to(:back)
    end

    it "should not update injected properties" do
      @controller.stubs(current_user: user)
      put :update, data
      controller.user.nickname.should eql(user.nickname)
    end

    it "should update nothing for wrong user" do
      put :update, data
      flash[:alert].should_not be_nil
      response.should redirect_to(root_url)
    end
  end
end

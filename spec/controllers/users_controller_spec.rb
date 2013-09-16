require 'spec_helper'

describe UsersController do
  let(:user) { create(:user) }
  let(:user_with_events) { create(:organizer_user) }
  let(:user_with_participations) { create(:participant_user) }
  let(:data) { {id: user.id, user: { github: 'testo', freelancer: true, available: true }} }
  let(:unallowed_data) { data.merge({:user => {:nickname => 'not_allowed_property'}}) }

  context "GET :show" do
    context "unknown user" do
      render_views

      it "rescues from not found" do
        get :show, id: "unknown"
        response.status.should eql(404)
      end
    end

    it "hides users via 404 if they do not participate in any event on a usergroup" do
      get :show, id: user.id
      response.status.should eql(404)
    end

    it "shows the user when organized an event" do
      get :show, id: user_with_events.id
      response.status.should eql(200)
    end

    it "shows the user participates an event" do
      get :show, id: user_with_participations.id
      response.status.should eql(200)
    end
  end

  context "GET :edit" do
    it "should show alert for wrong user" do
      get :edit, id: user
      flash[:alert].should_not be_nil
      response.should redirect_to(root_path)
    end
  end

  context "GET :calendar" do
    it "should show alert for wrong user" do
      get :calendar, id: user_with_participations, format: :ics
      expect(response.body).to match(/BEGIN:VCALENDAR/)
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
        response.should redirect_to(destroy_session_path)
      end

      it "should not delete an organizer" do
        @controller.stubs(current_user: event.user)
        expect do
          delete :destroy, id: event.user.id
        end.to change(User, :count).by(0)

        flash[:alert].should_not be_nil
        response.should redirect_to(edit_user_path(event.user))
      end
    end
  end

  context "PUT :update" do
    before { set_referer }

    it "should update the github attribute of a user" do
      controller.stubs(current_user: user)
      put :update, data
      controller.current_user.tap do |user|
        user.github.should eql('testo')
        user.freelancer.should be_true
        user.available.should be_true
      end
      response.should redirect_to(:back)
    end

    it "should not update injected properties" do
      controller.stubs(current_user: user)
      put :update, data
      controller.current_user.nickname.should eql(user.nickname)
    end

    it "should update nothing for wrong user" do
      put :update, data
      flash[:alert].should_not be_nil
      response.should redirect_to(root_path)
    end
  end
end

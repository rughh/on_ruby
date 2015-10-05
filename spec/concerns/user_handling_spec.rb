require "spec_helper"

describe "UserHandling", type: :controller do
  context "authenticate_admin_user!" do
    controller(HomeController) do
      before_action :authenticate_admin_user!
    end

    it "authenticates an action" do
      get :index
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to match("Admins")
    end

    it "accepts admin users" do
      allow(controller).to receive_messages(current_user: build(:admin_user))

      get :index
      expect(response).to be_a_success
    end
  end

  context "authenticate!" do
    controller(HomeController) do
      before_action :authenticate!
    end

    it "authenticates an action" do
      get :index
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to match("diese Seite")
    end
  end

  context "authenticate_current_user!" do
    controller(HomeController) do
      before_action :authenticate_current_user!
    end

    it "authenticates an action" do
      get :index
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to match("diese Seite")
    end

    it "redirects_if the user differs" do
      allow(controller).to receive_messages(signed_in?: true, current_user?: false)

      get :index
      expect(response).to redirect_to(root_path)
    end

    it "accepts only for the same user" do
      allow(controller).to receive_messages(signed_in?: true, current_user?: true)

      get :index
      expect(response).to be_a_success
    end
  end
end

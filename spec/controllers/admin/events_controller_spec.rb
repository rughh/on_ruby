require 'spec_helper'

describe Admin::EventsController do
  context "GET :index" do
    it "handles authentication" do
      get :index
      expect(response).to redirect_to(root_path)
    end

    context "with logged-in user" do
      let(:user) { build(:admin_user) }

      before do
        controller.stubs(current_user: user)
      end

      it "renders the index template" do
        get :index
        response.should render_template(:index)
      end
    end
  end
end
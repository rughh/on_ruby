require 'spec_helper'

describe SessionsController do
  before { set_subdomain }

  describe "GET :create" do
    before { request.env['omniauth.auth'] = TWITTER_AUTH_HASH }

    it "should render the :index template" do
      get :create, provider: :twitter
      controller.should be_signed_in
      response.should redirect_to(root_path)
    end
  end
end

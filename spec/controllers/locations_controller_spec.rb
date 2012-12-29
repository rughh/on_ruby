require 'spec_helper'

describe LocationsController do
  before { set_subdomain }

  describe "GET :index" do
    it "should render the :index template" do
      get :index
      response.should render_template(:index)
    end

    it "rescues from not found" do
      get :index, format: :mobile
      response.status.should eql(404)
    end
  end
end

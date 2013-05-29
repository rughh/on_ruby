require 'spec_helper'

describe LabelsController do
  context "GET :index" do
    it "renders the :index template" do
      get :index
      response.should render_template(:index)
    end

    it "renders the :index template for mobile devices" do
      get :index
      response.should render_template(:index)
    end
  end
end

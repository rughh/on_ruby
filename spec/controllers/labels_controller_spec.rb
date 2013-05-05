require 'spec_helper'

describe LabelsController do
  describe "GET :index" do
    it "should render the :index template" do
      get :index
      response.should render_template(:index)
    end
  end
end

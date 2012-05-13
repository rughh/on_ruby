require 'spec_helper'

describe LocationsController do

  before { set_subdomain }

  describe "GET :index" do
    before { get :index }

    it "should render the :index template" do
      response.should render_template(:index)
    end
  end

  describe "GET :company" do
    before { get :company }

    it "should render the :company template" do
      response.should render_template(:company)
    end
  end
end

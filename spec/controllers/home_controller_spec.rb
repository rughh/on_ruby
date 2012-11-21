require 'spec_helper'

describe HomeController do

  before { set_subdomain }

  describe "GET :index" do
    before { get :index }

    it "should render the :index template" do
      response.should render_template(:index)
    end
  end

  describe "GET :labels" do
    before { get :labels }

    it "should render the :labels template" do
      response.should render_template(:labels)
    end
  end
end

require 'spec_helper'

describe HomeController do

  describe "GET :info" do
    before { get :info }

    it "should render the :info template" do
      response.should render_template(:info)
    end
  end

  describe "GET :imprint" do
    before { get :imprint }

    it "should render the :imprint template" do
      response.should render_template(:imprint)
    end
  end

end

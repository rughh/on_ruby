require 'spec_helper'

describe MiscController do
  describe "GET :sitemap" do
    render_views

    before(:each) do
      create(:user)
    end

    it "should render the :index template" do
      get :sitemap, format: :xml
      response.should render_template(:sitemap)
      response.headers["Content-Type"].should eql("application/xml; charset=utf-8")
      response.body.should match("<loc>http://hamburg.test.host/")
      response.body.should match("<loc>http://hamburg.test.host/users/uschi-")
    end
  end
end

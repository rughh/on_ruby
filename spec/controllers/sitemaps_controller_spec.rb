require 'spec_helper'

describe SitemapsController do
  context "GET :show" do
    render_views

    before do
      create(:participant_user)
    end

    it "renders a sitemap" do
      get :show, id: 'hamburg', format: :xml
      response.should render_template(:show)
      response.headers["Content-Type"].should eql("application/xml; charset=utf-8")
      response.body.should match("<loc>http://hamburg.test.host/")
      response.body.should match("<loc>http://hamburg.test.host/users/uschi-")
    end
  end
end

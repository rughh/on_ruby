require 'spec_helper'

describe SitemapsController do
  context "GET :show" do
    it "renders a sitemap" do
      get :show, id: 'hamburg', format: :xml
      response.should render_template(:show)
      response.headers["Content-Type"].should eql("application/xml; charset=utf-8")
    end
  end
end

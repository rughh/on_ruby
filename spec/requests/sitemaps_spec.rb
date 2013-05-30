require 'spec_helper'

describe SitemapsController do
  context "GET :show" do
    before do
      create(:participant_user, nickname: 'uschi123')
    end

    it "renders a sitemap" do
      get sitemap_path(id: 'hamburg', format: :xml)
      response.body.should match("<loc>http://hamburg.onruby.dev/")
      response.body.should match("<loc>http://hamburg.onruby.dev/users/uschi123")
    end
  end
end

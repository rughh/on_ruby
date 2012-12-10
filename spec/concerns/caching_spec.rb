require "spec_helper"

describe HomeController, type: :controller do
  render_views

  before { set_subdomain }

  it "creates a cache-key based on the label" do
    with_caching do
      get :index

      Rails.cache.exist?("views/hamburg/home/index").should be_true
      IndexSweeper.expire_view_cache
      Rails.cache.exist?("views/hamburg/home/index").should be_false
    end
  end
end

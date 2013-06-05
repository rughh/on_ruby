require "spec_helper"

describe "Caching", type: :request do
  it "creates a cache-key based on the label" do
    with_caching do
      get root_path

      Rails.cache.exist?("views/hamburg/de/home/index").should be_true
      IndexSweeper.expire_view_cache
      Rails.cache.exist?("views/hamburg/de/home/index").should be_false
    end
  end
end

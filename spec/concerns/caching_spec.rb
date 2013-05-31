require "spec_helper"

describe "Caching", type: :request do
  let(:key) { "views/hamburg/home/index" }
  it "creates a cache-key based on the label" do
    with_caching do
      get root_path

      Rails.cache.exist?(key).should be_true
      IndexSweeper.expire_view_cache
      Rails.cache.exist?(key).should be_false
    end
  end
end

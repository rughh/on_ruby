require "spec_helper"

describe "Caching", type: :request do
  let(:key) { "views/hamburg/de/home/index" }

  it "creates a cache-key based on the label" do
    with_caching do
      get root_path

      Rails.cache.exist?(key).should be_true
      CacheExpiration.expire_view_cache
      Rails.cache.exist?(key).should be_false
    end
  end

  it "expires when a model updates" do
    with_caching do
      get root_path

      Rails.cache.exist?(key).should be_true
      create(:user)
      Rails.cache.exist?(key).should be_false
    end
  end
end

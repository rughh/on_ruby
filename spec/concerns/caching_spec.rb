require 'spec_helper'

describe 'Caching', type: :request do
  let(:key) { 'views/hamburg/de/home/index' }

  it 'creates a cache-key based on the label' do
    with_caching do
      get root_path

      expect {
        CacheExpiration.expire_view_cache
      }.to change {
        Rails.cache.exist?(key)
      }.from(true).to(false)
    end
  end

  it 'expires when a model updates' do
    with_caching do
      get root_path

      expect {
        create(:user)
      }.to change {
        Rails.cache.exist?(key)
      }.from(true).to(false)
    end
  end
end

require 'spec_helper'

describe 'Caching' do
  let(:key) { 'views/hamburg/de/home/index' }

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

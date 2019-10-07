require 'spec_helper'

describe 'Api' do
  before do
    ENV['HOR_API_KEY'] = 'bla'
  end

  context 'authorization' do
    it 'should redirect and have status not_authorized' do
      get api_path(format: :json), headers: { 'x-api-key' => '' }

      expect(response.status).to eql(401)
      expect(response.body).to be_empty
    end

    it 'should render json with valid api-key' do
      get api_path(format: :json), headers: { 'x-api-key' => ENV['HOR_API_KEY'] }

      expect(response).to be_ok
      expect(JSON.parse(response.body).keys).to eql(%w(topics locations events users))
    end
  end

  context 'flush' do
    it 'should render json with valid api-key' do
      get flush_path(format: :json), headers: { 'x-api-key' => ENV['HOR_API_KEY'] }

      expect(response).to be_ok
      expect(JSON.parse(response.body)).to eql({ "result" => "ok" })
    end
  end
end

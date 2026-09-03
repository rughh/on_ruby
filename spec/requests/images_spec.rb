require 'spec_helper'

describe 'Images', type: :request do
  describe 'GET /image/:timestamp/:model_name/:model_id/*filename' do
    let(:user) { create(:user, image: 'http://example.com/avatar.png') }

    def dispatch_path(model_name:, model_id:, filename: 'avatar.png')
      image_dispatch_path(timestamp: 1, model_name:, model_id:, filename:)
    end

    it 'proxies the uploaded image for a whitelisted mount' do
      stub_request(:get, 'http://example.com/avatar.png')
        .to_return(status: 200, body: 'PNGBYTES', headers: { 'Content-Type' => 'image/png' })

      get dispatch_path(model_name: 'User', model_id: user.id)

      expect(response).to have_http_status(:ok)
      expect(response.media_type).to eq('image/png')
      expect(response.body).to eq('PNGBYTES')
    end

    it 'falls back to the default image when the mount is empty' do
      user.update_column(:image, nil) # rubocop:disable Rails/SkipsModelValidations -- image has a presence validation

      get dispatch_path(model_name: 'User', model_id: user.id)

      expect(response).to have_http_status(:ok)
      expect(response.media_type).to eq('image/gif')
    end

    it 'falls back to the default image when the upstream fetch fails' do
      stub_request(:get, 'http://example.com/avatar.png').to_return(status: 500)

      get dispatch_path(model_name: 'User', model_id: user.id)

      expect(response).to have_http_status(:ok)
      expect(response.media_type).to eq('image/gif')
    end

    it 'does not proxy a model that is not whitelisted' do
      get dispatch_path(model_name: 'Event', model_id: 1)

      expect(response.body).not_to eq('PNGBYTES')
      expect(response.media_type).to eq('image/gif')
    end
  end
end

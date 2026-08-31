require 'spec_helper'

describe 'Sitemaps', type: :request do
  describe 'GET /sitemap.xml' do
    before { create(:participant_user, id: 999, nickname: 'uschi') }

    it 'renders a sitemap' do
      get sitemap_path(id: 'hamburg', format: :xml)

      expect(response.headers['Content-Type']).to eql('application/xml; charset=utf-8')
      expect(response.body).to match('<loc>http://hamburg.onruby.test/')
      expect(response.body).to match('<loc>http://hamburg.onruby.test/users/uschi-999')
    end
  end
end

require 'spec_helper'

describe SitemapsController do
  context 'GET :show' do
    before do
      create(:participant_user, id: 999, nickname: 'uschi')
    end

    it 'renders a sitemap' do
      get sitemap_path(id: 'hamburg', format: :xml)
      expect(response.body).to match('<loc>http://hamburg.onruby.dev/')
      expect(response.body).to match('<loc>http://hamburg.onruby.dev/users/uschi-999')
    end
  end
end

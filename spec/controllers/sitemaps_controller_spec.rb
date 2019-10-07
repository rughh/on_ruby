# frozen_string_literal: true

require 'spec_helper'

describe SitemapsController do
  context 'GET :show' do
    it 'renders a sitemap' do
      get :show, params: { id: 'hamburg', format: :xml }
      expect(response).to render_template(:show)
      expect(response.headers['Content-Type']).to eql('application/xml; charset=utf-8')
    end
  end
end

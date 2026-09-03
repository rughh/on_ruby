require 'spec_helper'

describe 'Admin: highlight management', type: :request do
  before { sign_in_via_github(admin: true) }

  describe 'GET /admin/highlights/new' do
    it 'renders the form' do
      get '/admin/highlights/new'

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /admin/highlights' do
    it 'creates a highlight' do
      expect do
        post '/admin/highlights', params: {
          highlight: {
            description: 'Conference tickets on sale',
            url: 'https://example.com/tickets',
            start_at: 1.day.from_now.iso8601,
            end_at: 1.week.from_now.iso8601,
          },
        }
      end.to change(Highlight, :count).by(1)

      highlight = Highlight.order(:created_at).last
      expect(response).to redirect_to(admin_highlight_path(highlight))
    end

    it 'does not create an invalid highlight' do
      expect do
        post '/admin/highlights', params: { highlight: { description: '', url: '', start_at: '', end_at: '' } }
      end.not_to change(Highlight, :count)

      expect(response).not_to have_http_status(:redirect)
    end
  end

  describe 'PATCH /admin/highlights/:id' do
    it 'updates the highlight' do
      highlight = create(:highlight)

      patch admin_highlight_path(highlight), params: { highlight: { description: 'Updated blurb' } }

      expect(highlight.reload.description).to eq('Updated blurb')
      expect(response).to redirect_to(admin_highlight_path(highlight))
    end
  end

  describe 'DELETE /admin/highlights/:id' do
    it 'deletes the highlight' do
      highlight = create(:highlight)

      expect { delete admin_highlight_path(highlight) }.to change(Highlight, :count).by(-1)
      expect(response).to redirect_to(admin_highlights_path)
    end
  end
end

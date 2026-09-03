require 'spec_helper'

describe 'Admin: material management', type: :request do
  before { sign_in_via_github(admin: true) }

  let(:event) { create(:event) }
  let(:topic) { create(:topic, event:) }
  let(:owner) { create(:user) }

  describe 'GET /admin/materials/new' do
    it 'renders the form' do
      get '/admin/materials/new'

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /admin/materials' do
    it 'creates a material' do
      expect do
        post '/admin/materials', params: {
          material: {
            name: 'Slides',
            url: 'https://example.com/slides.pdf',
            user_id: owner.id,
            event_id: event.id,
            topic_id: topic.id,
          },
        }
      end.to change(Material, :count).by(1)

      material = Material.order(:created_at).last
      expect(material).to have_attributes(name: 'Slides', event:, user: owner)
      expect(response).to redirect_to(admin_material_path(material))
    end

    it 'does not create a material with an invalid url' do
      expect do
        post '/admin/materials', params: {
          material: { name: 'Broken', url: 'not-a-url', user_id: owner.id, event_id: event.id, topic_id: topic.id },
        }
      end.not_to change(Material, :count)

      expect(response).not_to have_http_status(:redirect)
    end
  end

  describe 'PATCH /admin/materials/:id' do
    it 'updates the material' do
      material = create(:material, event:)

      patch admin_material_path(material), params: { material: { name: 'Renamed slides' } }

      expect(material.reload.name).to eq('Renamed slides')
      expect(response).to redirect_to(admin_material_path(material))
    end
  end

  describe 'DELETE /admin/materials/:id' do
    it 'deletes the material' do
      material = create(:material, event:)

      expect { delete admin_material_path(material) }.to change(Material, :count).by(-1)
      expect(response).to redirect_to(admin_materials_path)
    end
  end
end

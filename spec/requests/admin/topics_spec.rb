require 'spec_helper'

describe 'Admin: topic management', type: :request do
  before { sign_in_via_github(admin: true) }

  let(:proposer) { create(:user) }
  let(:event) { create(:event) }
  let(:valid_params) do
    {
      name: 'Lightning talk on Hotwire',
      description: 'Ten minutes on Turbo and Stimulus',
      proposal_type: 'proposal',
      user_id: proposer.id,
      event_id: event.id,
    }
  end

  describe 'GET /admin/topics/new' do
    it 'renders the form' do
      get '/admin/topics/new'

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /admin/topics' do
    it 'creates a topic' do
      expect { post '/admin/topics', params: { topic: valid_params } }.to change(Topic, :count).by(1)

      topic = Topic.order(:created_at).last
      expect(topic).to have_attributes(name: valid_params[:name], user: proposer, event: event, label: 'hamburg')
      expect(response).to redirect_to(admin_topic_path(topic))
    end

    it 'does not create an invalid topic' do
      expect do
        post '/admin/topics', params: { topic: valid_params.merge(name: '', description: '') }
      end.not_to change(Topic, :count)

      expect(response).not_to have_http_status(:redirect)
    end
  end

  describe 'PATCH /admin/topics/:id' do
    it 'updates the topic' do
      topic = create(:topic)

      patch admin_topic_path(topic), params: { topic: { name: 'Reworked proposal' } }

      expect(topic.reload.name).to eq('Reworked proposal')
      expect(response).to redirect_to(admin_topic_path(topic))
    end
  end
end

require 'spec_helper'

describe 'Topics', type: :request do
  describe 'GET /topics' do
    it 'renders the index' do
      create(:topic)

      get topics_path

      expect(response).to be_ok
    end
  end

  describe 'GET /topics/:id' do
    it 'renders the topic' do
      topic = create(:topic)

      get topic_path(topic)

      expect(response).to be_ok
      expect(response.body).to include(topic.name)
    end
  end

  describe 'GET /topics/new' do
    it 'redirects anonymous visitors to the login' do
      get new_topic_path

      expect(response).to redirect_to(login_path)
      expect(flash[:alert]).to eq(I18n.t('flash.not_logged_in'))
    end

    it 'renders the form for a signed-in user' do
      login_as(create(:user))

      get new_topic_path

      expect(response).to be_ok
    end
  end

  describe 'GET /topics/:id/edit' do
    it 'renders the form for the owner' do
      user = create(:user)
      topic = create(:topic, user:)
      login_as(user)

      get edit_topic_path(topic)

      expect(response).to be_ok
    end

    it 'redirects a different user away' do
      topic = create(:topic)
      login_as(create(:user))

      get edit_topic_path(topic)

      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq(I18n.t('flash.not_authenticated'))
    end
  end

  describe 'POST /topics' do
    let(:topic_data) { attributes_for(:topic) }

    it 'creates a topic for a signed-in user' do
      user = login_as(create(:user))

      expect { post topics_path, params: { topic: topic_data } }.to change(Topic, :count).by(1)

      topic = Topic.order(:created_at).last
      expect(topic.user).to eq(user)
      expect(response).to redirect_to(topic_path(topic))
      expect(flash[:notice]).not_to be_nil
    end

    it 'redirects a user without an email to complete their profile' do
      user = login_as(create(:user, email: ''))

      expect { post topics_path, params: { topic: topic_data } }.to change(Topic, :count).by(1)

      expect(response).to redirect_to(edit_user_path(user))
    end

    it 'does not create a topic when not signed in' do
      expect { post topics_path, params: { topic: topic_data } }.not_to change(Topic, :count)

      expect(response).to redirect_to(login_path)
    end
  end

  describe 'PATCH /topics/:id' do
    it 'redirects anonymous visitors to the login' do
      patch topic_path(create(:topic)), params: { topic: { name: 'nope' } }

      expect(response).to redirect_to(login_path)
      expect(flash[:alert]).to eq(I18n.t('flash.not_logged_in'))
    end

    it 'updates the topic for its owner' do
      user = create(:user)
      topic = create(:topic, user:)
      login_as(user)

      patch topic_path(topic), params: { topic: { name: 'blupp' } }

      expect(topic.reload.name).to eq('blupp')
      expect(flash[:notice]).not_to be_nil
    end

    it 'updates any topic for an admin' do
      topic = create(:topic)
      login_as(create(:admin_user))

      patch topic_path(topic), params: { topic: { name: 'zapp' } }

      expect(topic.reload.name).to eq('zapp')
    end

    it 'does not update the topic for a different user' do
      topic = create(:topic)
      login_as(create(:user))

      patch topic_path(topic), params: { topic: { name: 'blupp' } }

      expect(response).to redirect_to(root_path)
      expect(topic.reload.name).not_to eq('blupp')
    end
  end
end

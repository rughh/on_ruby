require 'spec_helper'

# The Admin:: request specs cover CRUD in detail. These pin down the parallel
# SuperAdmin:: controllers, which are separate classes that operate on
# `resource_class.unscoped` -- so a regression there would not be caught by the
# Admin:: specs.
describe 'Super admin: resource management', type: :request do
  before { sign_in_via_github(admin: true, super_admin: true) }

  describe 'jobs' do
    let(:location) { create(:location) }

    it 'creates and then deletes a job posting' do
      expect do
        post '/super_admin/jobs', params: {
          job: { name: 'Staff Rubyist', url: 'https://jobs.example/staff', location_id: location.id },
        }
      end.to change(Job, :count).by(1)

      job = Job.unscoped.order(:created_at).last
      expect(response).to redirect_to(super_admin_job_path(job))

      expect { delete super_admin_job_path(job) }.to change(Job, :count).by(-1)
      expect(response).to redirect_to(super_admin_jobs_path)
    end
  end

  describe 'locations' do
    it 'creates and then deletes a location' do
      expect do
        post '/super_admin/locations', params: {
          location: {
            name: 'Betahaus', url: 'https://betahaus.de',
            street: 'Eifflerstraße', house_number: '43', city: 'Hamburg', zip: '22769',
          },
        }
      end.to change(Location, :count).by(1)

      location = Location.unscoped.order(:created_at).last
      expect(response).to redirect_to(super_admin_location_path(location))

      expect { delete super_admin_location_path(location) }.to change(Location, :count).by(-1)
      expect(response).to redirect_to(super_admin_locations_path)
    end
  end

  describe 'topics' do
    let(:proposer) { create(:user) }
    let(:event) { create(:event) }

    it 'creates and then deletes a topic' do
      expect do
        post '/super_admin/topics', params: {
          topic: {
            name: 'Hotwire lightning talk', description: 'Ten minutes on Turbo',
            proposal_type: 'proposal', user_id: proposer.id, event_id: event.id,
          },
        }
      end.to change(Topic, :count).by(1)

      topic = Topic.unscoped.order(:created_at).last
      expect(response).to redirect_to(super_admin_topic_path(topic))

      expect { delete super_admin_topic_path(topic) }.to change(Topic, :count).by(-1)
      expect(response).to redirect_to(super_admin_topics_path)
    end
  end

  describe 'users' do
    it 'edits and then deletes a user' do
      user = create(:user)

      patch super_admin_user_path(user), params: { user: { name: 'Renamed By Super Admin' } }

      expect(user.reload.name).to eq('Renamed By Super Admin')
      expect(response).to redirect_to(super_admin_user_path(user))

      expect { delete super_admin_user_path(user) }.to change(User, :count).by(-1)
      expect(response).to redirect_to(super_admin_users_path)
    end
  end
end

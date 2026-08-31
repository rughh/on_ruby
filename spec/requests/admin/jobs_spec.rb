require 'spec_helper'

describe 'Admin: job management', type: :request do
  before { sign_in_via_github(admin: true) }

  let(:location) { create(:location) }

  describe 'GET /admin/jobs/new' do
    it 'renders the form' do
      get '/admin/jobs/new'

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /admin/jobs' do
    it 'creates a job posting' do
      expect do
        post '/admin/jobs', params: {
          job: { name: 'Senior Rubyist', url: 'https://jobs.example/senior-rubyist', location_id: location.id },
        }
      end.to change(Job, :count).by(1)

      job = Job.order(:created_at).last
      expect(job).to have_attributes(name: 'Senior Rubyist', location: location, label: 'hamburg')
      expect(response).to redirect_to(admin_job_path(job))
    end

    it 'does not create an invalid job posting' do
      expect do
        post '/admin/jobs', params: { job: { name: '', url: '', location_id: location.id } }
      end.not_to change(Job, :count)

      expect(response).not_to have_http_status(:redirect)
    end
  end

  describe 'PATCH /admin/jobs/:id' do
    it 'updates the job posting' do
      job = create(:job)

      patch admin_job_path(job), params: { job: { name: 'Staff Rubyist' } }

      expect(response).to redirect_to(admin_job_path(job))
      expect(job.reload.name).to eq('Staff Rubyist')
    end
  end

  describe 'DELETE /admin/jobs/:id' do
    it 'deletes the job posting' do
      job = create(:job)

      expect { delete admin_job_path(job) }.to change(Job, :count).by(-1)
      expect(response).to redirect_to(admin_jobs_path)
    end
  end
end

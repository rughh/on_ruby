require 'spec_helper'

describe 'Home page cache', type: :request do
  around do |example|
    ActionController::Base.perform_caching = true
    ActionController::Base.cache_store = ActiveSupport::Cache::MemoryStore.new
    example.run
  ensure
    ActionController::Base.perform_caching = false
    ActionController::Base.cache_store = Rails.cache
  end

  let(:berlin) { Whitelabel.label_for('berlin') }

  # The page features only the next upcoming event, so a later-created, earlier-dated
  # event replaces it as soon as the page is rendered again.
  before { create(:event, name: 'Hamburg Meetup', date: 2.days.from_now) }

  it 'caches the page for anonymous visitors, per label and locale', :aggregate_failures do
    get root_url(subdomain: 'hamburg')
    expect(response.body).to include('Hamburg Meetup')

    create(:event, name: 'Added Later', date: 1.day.from_now)
    get root_url(subdomain: 'hamburg')
    expect(response.body).not_to include('Added Later')

    Whitelabel.with_label(berlin) { create(:event, name: 'Berlin Meetup', date: 1.day.from_now) }
    get root_url(subdomain: 'berlin')
    expect(response.body).to include('Berlin Meetup')
    expect(response.body).not_to include('Hamburg Meetup')

    get root_url(subdomain: 'hamburg', locale: 'en')
    expect(response.body).to include('Added Later')
  end

  it 'renders the page live for signed-in users' do
    get root_url(subdomain: 'hamburg')
    sign_in_via_github
    create(:event, name: 'Added Later', date: 1.day.from_now)

    get root_url(subdomain: 'hamburg')

    expect(response.body).to include('Added Later')
  end
end

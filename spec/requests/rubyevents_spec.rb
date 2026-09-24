# frozen_string_literal: true

require 'spec_helper'

describe 'RubyEvents feed' do
  before { host! 'hamburg.onruby.test' }

  it 'serves the series as yaml' do
    get '/.well-known/rubyevents/series.yml'

    expect(response).to be_ok
    expect(response.media_type).to eq('application/yaml')
    expect(YAML.safe_load(response.body)).to include('id' => 'hamburg', 'kind' => 'meetup')
  end

  it 'serves the event as yaml' do
    get '/.well-known/rubyevents/event.yml'

    expect(YAML.safe_load(response.body)).to include('id' => 'hamburg-meetup')
  end

  it 'scopes the feed to the requested usergroup' do
    host! 'berlin.onruby.test'

    get '/.well-known/rubyevents/series.yml'

    expect(YAML.safe_load(response.body)['id']).to eq('berlin')
  end

  it 'sends Last-Modified so a fetcher can revalidate' do
    create(:event, date: 1.month.ago)

    get '/.well-known/rubyevents/event.yml'

    expect(response.headers['Last-Modified']).to be_present
  end

  it 'answers a conditional GET with 304' do
    create(:event, date: 1.month.ago)
    get '/.well-known/rubyevents/event.yml'

    get '/.well-known/rubyevents/event.yml',
        headers: { 'HTTP_IF_MODIFIED_SINCE' => response.headers['Last-Modified'] }

    expect(response).to have_http_status(:not_modified)
  end

  it 'ignores topic proposals that are not on an event yet' do
    create(:event, date: 1.month.ago)
    get '/.well-known/rubyevents/event.yml'
    unchanged = response.headers['Last-Modified']

    travel 1.hour do
      create(:proposal)

      get '/.well-known/rubyevents/event.yml'
    end

    expect(response.headers['Last-Modified']).to eq(unchanged)
  end

  it 'does not serve other formats' do
    get '/.well-known/rubyevents/series.json'

    expect(response).to have_http_status(:not_found)
  end
end

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

  it 'serves the editions as a yaml list' do
    create(:event, name: 'September Meetup', date: 1.month.ago)

    get '/.well-known/rubyevents/videos.yml'

    expect(YAML.safe_load(response.body).map { |it| it['title'] }).to eq(['September Meetup'])
  end

  it 'revalidates when a material changes, since talks carry its slides url' do
    event = create(:event, date: 1.month.ago)
    topic = create(:topic, event:)
    material = create(:material, event:, topic:)
    get '/.well-known/rubyevents/videos.yml'
    before = response.headers['Last-Modified']

    travel 1.hour do
      material.update!(url: 'https://slides.example.org/v2')

      get '/.well-known/rubyevents/videos.yml'
    end

    expect(response.headers['Last-Modified']).not_to eq(before)
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

  it 'serves the speakers as a yaml list with handles' do
    user = create(:user, name: 'Ada Lovelace', github: 'AdaLovelace')
    event = create(:event, date: 1.month.ago, user:)
    create(:topic, event:, user:)

    get '/.well-known/rubyevents/speakers.yml'

    expect(response.media_type).to eq('application/yaml')
    expect(YAML.safe_load(response.body).first)
      .to include('name' => 'Ada Lovelace', 'slug' => 'ada-lovelace', 'github' => 'adalovelace')
  end

  it 'serves the sponsors as yaml with absolute logo urls' do
    get '/.well-known/rubyevents/sponsors.yml'

    sponsor = YAML.safe_load(response.body).first['tiers'].first['sponsors'].first

    expect(response.media_type).to eq('application/yaml')
    expect(sponsor).to include('name' => 'AppSignal')
    expect(sponsor['logo_url']).to start_with('https://hamburg.onruby.de/assets/')
  end

  it 'does not serve other formats' do
    get '/.well-known/rubyevents/series.json'

    expect(response).to have_http_status(:not_found)
  end
end

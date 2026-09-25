# frozen_string_literal: true

require 'spec_helper'

describe 'rubyevents feed routing' do
  it 'routes series.yml' do
    expect(get: '/.well-known/rubyevents/series.yml')
      .to route_to(controller: 'rubyevents', action: 'series', format: 'yml')
  end

  it 'routes event.yml' do
    expect(get: '/.well-known/rubyevents/event.yml')
      .to route_to(controller: 'rubyevents', action: 'event', format: 'yml')
  end

  it 'routes videos.yml' do
    expect(get: '/.well-known/rubyevents/videos.yml')
      .to route_to(controller: 'rubyevents', action: 'videos', format: 'yml')
  end

  it 'routes speakers.yml' do
    expect(get: '/.well-known/rubyevents/speakers.yml')
      .to route_to(controller: 'rubyevents', action: 'speakers', format: 'yml')
  end

  it 'serves yaml for the extensionless path too' do
    expect(get: '/.well-known/rubyevents/series')
      .to route_to(controller: 'rubyevents', action: 'series', format: 'yml')
  end
end

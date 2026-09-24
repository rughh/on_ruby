# frozen_string_literal: true

require 'spec_helper'

describe 'the :yaml renderer', type: :controller do
  controller(ActionController::Base) do
    def index
      render yaml: { 'id' => 'hamburg', 'description' => "Talk: Kafka at scale\n\nWe meet at 19:00." }
    end
  end

  before { routes.draw { get 'index' => 'anonymous#index' } }

  it 'serves the RFC 9512 content type, not the deprecated application/x-yaml' do
    get :index

    expect(response.media_type).to eq('application/yaml')
  end

  it 'serialises the object as YAML' do
    get :index

    expect(YAML.safe_load(response.body)).to include('id' => 'hamburg')
  end

  it 'escapes a description containing colons and newlines' do
    get :index

    expect(YAML.safe_load(response.body)['description']).to eq("Talk: Kafka at scale\n\nWe meet at 19:00.")
  end
end

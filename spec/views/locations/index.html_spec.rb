# frozen_string_literal: true

require 'spec_helper'

describe 'locations/index' do
  let(:locations) { [build(:location)] }

  it 'should render successfully' do
    allow(view).to receive_messages(locations: locations)

    render
  end
end

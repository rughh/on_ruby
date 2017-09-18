require 'spec_helper'

describe 'locations/show' do
  let(:location) { build(:location) }

  it 'should render successfully' do
    allow(view).to receive_messages(location: location)

    render
  end
end

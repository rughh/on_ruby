require 'spec_helper'

describe 'locations/index' do
  let(:locations) { [build(:location)] }

  it 'renders successfully' do
    allow(view).to receive_messages(locations:)

    render
  end
end

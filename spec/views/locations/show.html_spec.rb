require 'spec_helper'

describe 'locations/show' do
  let(:location) { build(:location) }

  it 'renders successfully' do
    allow(view).to receive_messages(location:)
    view.lookup_context.prefixes = %w[locations application]

    render
  end
end

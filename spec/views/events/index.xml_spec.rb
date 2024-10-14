require 'spec_helper'

describe 'events/index' do
  let(:events) { Array.new(3) { build(:event, id: 123) } }

  it 'renders successfully' do
    allow(view).to receive_messages(events:)
    render

    expect(rendered).to include(events.first.name)
  end
end

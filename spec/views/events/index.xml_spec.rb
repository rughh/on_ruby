require 'spec_helper'

describe 'events/index' do
  let(:events) { Array.new(3) { build(:event, id: 123) } }

  it 'renders successfully' do
    allow(view).to receive_messages(events: events)
    render
  end
end

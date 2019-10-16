require 'spec_helper'

describe 'events/index' do
  let(:event) { build(:event, id: 123) }

  it 'should render successfully' do
    allow(view).to receive_messages(events: paged(event))

    render
  end
end

require 'spec_helper'

describe 'events/index' do
  let(:event) { build(:event, id: 123) }

  it 'renders successfully' do
    allow(view).to receive_messages(events: paged(event))

    render

    expect(rendered).to include(event.name)
  end
end

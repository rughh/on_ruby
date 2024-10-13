require 'spec_helper'

describe 'topics/index' do
  let(:event) { build(:event) }

  it 'renders successfully' do
    allow(view).to receive_messages(events: paged(event))

    render

    expect(rendered).to include(event.name)
  end
end

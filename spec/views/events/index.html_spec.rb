require 'spec_helper'

describe 'events/index' do
  let(:event) { build(:event, id: 123) }

  it 'renders successfully' do
    allow(view).to receive_messages(events: paged(event), signed_in?: false)

    render template: 'events/index', formats: [:html]

    expect(rendered).to include(event.name)
  end
end

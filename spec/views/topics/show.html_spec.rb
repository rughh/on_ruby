require 'spec_helper'

describe 'topics/show' do
  let(:topic) { build(:topic, user: build(:user, id: 123)) }

  it 'renders successfully' do
    allow(view).to receive_messages(topic:, signed_in?: false)

    render

    expect(rendered).to include(topic.name)
  end

  context 'materials' do
    let(:materials) { [build(:material)] }

    it 'renders without an error' do
      render partial: 'materials', locals: { materials: }

      expect(rendered).to include(materials.first.name)
    end
  end
end

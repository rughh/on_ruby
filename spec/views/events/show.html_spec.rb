require 'spec_helper'

describe 'events/show' do
  let(:user)  { build(:user, id: 456) }
  let(:event) { build(:event, id: 123) }

  it 'renders successfully' do
    allow(view).to receive_messages(signed_in?: true, current_user: user, event: event, likes: '</>')
    view.lookup_context.prefixes = %w[events application]

    expect(rendered).not_to be_nil
  end

  context 'materials' do
    let(:materials) { [build(:material)] }

    it 'renders without an error' do
      render partial: 'materials', locals: { materials: materials }

      expect(rendered).not_to be_nil
    end
  end
end

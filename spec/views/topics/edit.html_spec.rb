require 'spec_helper'

describe 'topics/edit' do
  let(:topic) { build(:topic) }
  let(:user) { build(:user) }

  it 'renders successfully' do
    allow(view).to receive_messages(current_user: user, topic:, undone_topics: [topic])

    render
  end
end

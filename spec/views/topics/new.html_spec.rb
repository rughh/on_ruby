require 'spec_helper'

describe 'topics/new' do
  let(:topic) { Topic.new }

  it 'renders successfully' do
    allow(view).to receive_messages(signed_in?: true, topic: topic, undone_topics: [topic])

    render
  end
end

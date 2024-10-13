require 'spec_helper'

describe 'users/show' do
  let(:user) { build(:user, id: 123) }

  it 'renders successfully' do
    allow(view).to receive_messages(current_user: user, user:)

    render

    expect(rendered).to include(user.nickname)
  end
end

require 'spec_helper'

describe 'users/edit' do
  let(:user) { build(:user) }

  it 'should render successfully' do
    allow(view).to receive_messages(current_user: user, user: user)

    render
  end
end

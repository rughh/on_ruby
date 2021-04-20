require 'spec_helper'

describe 'labels/index' do
  it 'renders successfully' do
    Whitelabel.reset!

    render
  end
end

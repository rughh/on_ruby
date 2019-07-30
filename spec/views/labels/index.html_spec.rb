# typed: false
require 'spec_helper'

describe 'labels/index' do
  it 'should render successfully' do
    Whitelabel.reset!

    render
  end
end

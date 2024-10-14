require 'spec_helper'

describe 'labels/index' do
  it 'renders successfully' do
    Whitelabel.reset!

    render

    expect(rendered).to include(Whitelabel.labels.select(&:enabled?).first.label_id)
  end
end

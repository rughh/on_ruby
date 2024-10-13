require 'spec_helper'

describe 'sitemaps/show' do
  let(:example_urls) { %w[url1 url2] }

  it 'renders successfully' do
    allow(view).to receive_messages(urls: example_urls)

    render

    expect(rendered).to include(example_urls.first)
  end
end

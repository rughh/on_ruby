require 'spec_helper'

describe 'sitemaps/show' do
  let(:example_urls) { %w[url1 url2] }

  it 'should render successfully' do
    allow(view).to receive_messages(urls: example_urls)

    render
  end
end

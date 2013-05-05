require "spec_helper"

describe "misc/sitemap" do

  let(:example_urls) { ['url1', 'url2'] }

  it "should render successfully" do
    view.stubs(urls: example_urls)
    render
  end

end

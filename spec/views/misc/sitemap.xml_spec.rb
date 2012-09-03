require "spec_helper"

describe "misc/sitemap" do

  let(:urls) { ['url1', 'url2'] }

  it "should render successfully" do
    view.stubs(urls: urls)
    render
  end

end

require 'spec_helper'

describe "Labels" do
  context "GET /" do
    before do
      host! "www.onruby.dev"
    end

    it "works!" do
      get "/"
      response.status.should be(200)
    end

    it "also works for mobile devices" do
      get "/?mobile=1"
      response.status.should be(200)
    end
  end
end

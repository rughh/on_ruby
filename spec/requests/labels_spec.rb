require 'spec_helper'

describe "Labels" do
  context "GET /" do
    before do
      host! "www.onruby.dev"
    end

    it "works!" do
      get "/"
      expect(response).to be_ok
    end

    it "also works for mobile devices" do
      get "/?mobile=1"
      expect(response).to be_ok
    end
  end
end

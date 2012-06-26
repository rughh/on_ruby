require 'spec_helper'

describe "Events" do

  before { ActionDispatch::Request.any_instance.stubs(:subdomains).returns(['hamburg']) }

  let(:event) { create(:event) }

  describe "GET /events" do
    it "works!" do
      get event_path(event)
      response.status.should be(200)
    end
  end
end

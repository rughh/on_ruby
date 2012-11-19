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

  describe "GET /events.son" do
    it "renders valid json" do
      get event_path(event, format: :json)
      json = JSON.parse(response.body)
      json['name'].should eql(event.name)
    end
  end
end

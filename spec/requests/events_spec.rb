require 'spec_helper'

describe "Events" do

  before(:each) do
    ActionDispatch::Request.any_instance.stubs(:subdomains).returns(['hamburg'])
  end

  let(:event) { FactoryGirl.create(:event) }

  describe "GET /events" do
    it "works!" do
      get event_path(event)
      response.status.should be(200)
    end
  end
end

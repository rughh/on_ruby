require 'spec_helper'

describe "Events" do

  let(:event) { Factory(:event) }

  describe "GET /events" do
    it "works!" do
      get event_path(event)
      response.status.should be(200)
    end
  end
end

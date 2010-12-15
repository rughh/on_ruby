require 'spec_helper'

describe "Events" do
  describe "GET /events" do
    it "works!" do
      get event_path(Factory(:event))
      response.status.should be(200)
    end
  end
end

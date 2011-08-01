require 'spec_helper'

describe HomeHelper do
  describe "#next_event_date" do
    it "should always be on a wendsday" do
      next_event_date.should be_wednesday
      next_event_date.should be > Date.today
    end
  end
end

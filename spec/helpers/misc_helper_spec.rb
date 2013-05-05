require 'spec_helper'

describe MiscHelper do
  it "returns the right urls" do
    create(:event, name: 'tesssstooo', label: 'hamburg')
    helper.urls('hamburg').should eql(["http://hamburg.test.host/events/tesssstooo", "http://hamburg.test.host/locations/blau-mobilfunk-gmbh", "http://hamburg.test.host/"])
  end
end

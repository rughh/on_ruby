require "spec_helper"

describe "mobile/home/index" do
  let(:event) { build(:event, id: 123) }
  let(:topic) { build(:topic, id: 123) }
  let(:user) { build(:user, id: 123) }
  let(:location) { build(:location, id: 123) }

  it "should render successfully" do
    locals = {
      current_event: event,
      events: [event],
      undone_topics: [topic],
      done_topics: [topic],
      people: [user],
      locations: [location],
    }
    view.stubs(locals)
    render
  end
end

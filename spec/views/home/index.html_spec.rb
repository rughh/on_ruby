require "spec_helper"

describe "home/index" do

  let(:event)     { build(:event) }
  let(:user)      { build(:user) }
  let(:location)  { build(:location) }
  let(:topic)     { build(:topic) }
  let(:company)   { build(:location, company: true) }

  it "should render successfully" do
    view.stubs(events: [event], current_event: event, people: [user], locations: [location], topics_done: [topic], topics_undone: [topic], organizers: [user], companies: [company], main_user: user)
    view.stubs(signed_in?: false)
    render
  end

end

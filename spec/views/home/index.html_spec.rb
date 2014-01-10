require "spec_helper"

describe "home/index" do
  let(:event)     { build(:event, id: 123) }
  let(:user)      { build(:user) }
  let(:location)  { build(:location) }
  let(:topic)     { build(:topic) }
  let(:company)   { build(:location, company: true) }

  it "should render successfully" do
    view.stub(events: [event], current_event: event, people: [user])
    view.stub(locations: [location], done_topics: [topic])
    view.stub(undone_topics: [topic], organizers: [user])
    view.stub(companies: [company], main_user: user, signed_in?: false)

    render
  end
end

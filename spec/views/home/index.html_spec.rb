require 'spec_helper'

describe 'home/index' do
  let(:event)     { build(:event, id: 123) }
  let(:user)      { build(:user) }
  let(:location)  { build(:location) }
  let(:topic)     { build(:topic) }
  let(:company)   { build(:location, company: true) }
  let(:zoom)      { rand(1..20) }

  it 'should render successfully' do
    allow(view).to receive_messages(events: [event], current_event: event, people: [user])
    allow(view).to receive_messages(locations: [location], done_topics: [topic])
    allow(view).to receive_messages(undone_topics: [topic], organizers: [user], upcoming_topics: [topic])
    allow(view).to receive_messages(companies: [company], main_user: user, signed_in?: false)
    allow(view).to receive_messages(zoom: zoom)

    render
  end
end

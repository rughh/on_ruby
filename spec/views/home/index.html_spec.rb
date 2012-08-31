require "spec_helper"

describe "home/index" do

  let(:event)     { build(:event) }
  let(:user)      { build(:user) }
  let(:location)  { build(:location) }
  let(:wish)      { build(:wish) }
  let(:company)   { build(:location, company: true) }

  it "should render successfully" do
    view.stubs(events: [event], current_event: event, people: [user], locations: [location], wishes_done: [wish], wishes_undone: [wish], organizers: [user], companies: [company], main_user: user)
    view.stubs(signed_in?: false)
    render
  end

end

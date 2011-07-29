require "spec_helper"

describe "home/index.html.haml" do

  let(:event)     { Factory(:event) }
  let(:user)      { Factory(:user) }
  let(:location)  { Factory(:location) }
  let(:wish)      { Factory(:wish) }
  let(:company)   { Factory(:location, company: true) }

  it "should render successfully" do
    view.stubs(events: [event], current_event: event, people: [user], locations: [location], wishes: [wish], organizers: [user], companies: [company], main_user: user)
    view.stubs(signed_in?: false)
    render
  end

end

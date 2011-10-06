require "spec_helper"

describe "home/index.html.haml" do

  let(:event)     { Factory.build(:event) }
  let(:user)      { Factory.build(:user) }
  let(:location)  { Factory.build(:location) }
  let(:wish)      { Factory.build(:wish) }
  let(:company)   { Factory.build(:location, company: true) }

  it "should render successfully" do
    view.stubs(events: [event], current_event: event, people: [user], locations: [location], wishes: [wish], organizers: [user], companies: [company], main_user: user)
    view.stubs(signed_in?: false)
    render
  end

end

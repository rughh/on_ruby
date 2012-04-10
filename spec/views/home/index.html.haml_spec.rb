require "spec_helper"

describe "home/index" do

  let(:event)     { FactoryGirl.build(:event) }
  let(:user)      { FactoryGirl.build(:user) }
  let(:location)  { FactoryGirl.build(:location) }
  let(:wish)      { FactoryGirl.build(:wish) }
  let(:company)   { FactoryGirl.build(:location, company: true) }

  it "should render successfully" do
    view.stubs(events: [event], current_event: event, people: [user], locations: [location], wishes_done: [wish], wishes_undone: [wish], organizers: [user], companies: [company], main_user: user)
    view.stubs(signed_in?: false)
    render
  end

end

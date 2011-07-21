require "spec_helper"

describe "/home/index" do
  
  before do
    @event    = Factory(:event)
    @user     = Factory(:user)
    @location = Factory(:location)
    @wish     = Factory(:wish)
    @company  = Factory(:location, company: true)
  end

  it "should render successfully" do
    view.stubs(events: [@event], current_event: @event, people: [@user], locations: [@location], wishes: [@wish], organizers: [@user], companies: [@company], main_user: @user)
    view.stubs(signed_in?: false)
    render
  end

end

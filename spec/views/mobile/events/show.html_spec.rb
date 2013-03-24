require "spec_helper"

describe "mobile/events/show", type: :view do
  let(:user)  { build(:user) }
  let(:event) { build(:event, id: 123) }

  it "should render successfully" do
    view.stubs(signed_in?: true, current_user: user, event: event)
    render
  end
end

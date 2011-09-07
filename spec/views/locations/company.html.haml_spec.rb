require "spec_helper"

describe "locations/company.html.haml" do

  let(:companies) { [Factory(:location, company: true)] }
  let(:user) { Factory(:user) }

  it "should render successfully" do
    view.stubs(main_user: user, companies: companies)
    render
  end

end

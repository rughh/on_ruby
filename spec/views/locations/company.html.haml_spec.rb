require "spec_helper"

describe "locations/company.html.haml" do

  let(:companies) { [Factory.build(:location, company: true)] }
  let(:user) { Factory.build(:user) }

  it "should render successfully" do
    view.stubs(main_user: user, companies: companies)
    render
  end

end

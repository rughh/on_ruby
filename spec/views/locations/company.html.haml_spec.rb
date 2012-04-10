require "spec_helper"

describe "locations/company" do

  let(:companies) { [FactoryGirl.build(:location, company: true)] }
  let(:user) { FactoryGirl.build(:user) }

  it "should render successfully" do
    view.stubs(main_user: user, companies: companies)
    render
  end

end

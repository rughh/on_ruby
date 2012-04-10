require 'spec_helper'

describe WishHelper do

  let(:wish) { FactoryGirl.create(:wish) }

  describe "wish description" do
    it "should render a list of stars" do
      helper.stubs(signed_in?: true, current_user: wish.user)
      output = helper.stars(wish)
      output.scan('<a href').should have(5).things
    end
  end
end

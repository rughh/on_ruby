require 'spec_helper'

describe "Wishes" do

  before do
    ActionDispatch::Request.any_instance.stubs(:subdomains).returns(['hamburg'])
    WishesController.any_instance.stubs(:current_user).returns(build(:user, id: 123))
  end

  describe "GET /wishes/new" do
    it "works!" do
      get new_wish_path
      response.status.should be(200)
    end
  end
end

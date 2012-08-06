require 'spec_helper'

describe "Dashboard" do

  before { ActionDispatch::Request.any_instance.stubs(:subdomains).returns(['hamburg']) }

  describe "GET /admin" do
    context "admin user" do
      before { Admin::DashboardController.any_instance.stubs(:current_user).returns(build(:admin_user)) }

      it "should not access the admin interface" do
        get admin_root_path
        response.should be_success
      end
    end

    context "normal user" do
      before { Admin::DashboardController.any_instance.stubs(:current_user).returns(build(:user)) }

      it "should not access the admin interface" do
        get admin_root_path
        response.should redirect_to(root_path)
      end
    end
  end
end

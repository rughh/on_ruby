require 'spec_helper'

describe "Topics" do

  before do
    ActionDispatch::Request.any_instance.stubs(:subdomains).returns(['hamburg'])
    TopicsController.any_instance.stubs(:current_user).returns(build(:user, id: 123))
  end

  describe "GET /topics/new" do
    it "works!" do
      get new_topic_path
      response.status.should be(200)
    end
  end
end

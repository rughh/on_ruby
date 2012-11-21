require 'spec_helper'

describe HomeController, type: :controller do

  before { set_subdomain }

  describe "caching condition" do
    it "should not cache for mobile user agents" do
      controller.request.stubs(user_agent: "Mobile Safari")
      get :index
      controller.class.caches_action_condition(controller).should be_false
    end

    it "should not cache for mobile user agents" do
      get :index, format: :mobile
      controller.class.caches_action_condition(controller).should be_false
    end

    it "should cache for other formats" do
      get :index
      controller.class.caches_action_condition(controller).should be_true
    end
  end

  describe "cache path" do
    let(:date) { Date.new(2012, 07, 07) }
    let(:standard_options) { {"controller"=>"home", "action"=>"index", "locale"=>"de", "date"=>"2012-07-06", "format"=>"text/html_html"} }
    let(:mobile_options)   { {"controller"=>"home", "action"=>"index", "locale"=>"de", "date"=>"2012-07-06", "format"=>"text/html_mobile"} }

    it "should generate valid cache path options" do
      Timecop.freeze date do
        get :index
        controller.class.caches_action_cache_path(controller).should eql(standard_options)
      end
    end

    it "should generate different cache path options for mobile requests" do
      Timecop.freeze date do
        controller.request.stubs(user_agent: "Mobile Safari")
        get :index
        controller.class.caches_action_cache_path(controller).should eql(mobile_options)
      end
    end
  end
end

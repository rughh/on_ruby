require 'spec_helper'

describe EventsController do

  def mock_event(stubs={})
    (@mock_event ||= mock_model(Event).as_null_object).tap do |event|
      event.stub(stubs) unless stubs.empty?
    end
  end
  
  def mock_data
    'moooooooooockmockmock'
  end
  
  before(:each) do
    Event.stub(:preview_events) { [mock_event] }
    @controller.stub(:cache) { [mock_data] }
  end
  
  describe "GET info" do
    it "assigns all preview data" do
      get :info
      assigns(:preview_events).should eq([mock_event])
      assigns(:tweets).should eq([mock_data])
      assigns(:random_users).should eq([mock_data])
    end
  end
  
  describe "GET show" do
    it "assigns the requested event as @event" do
      Event.stub(:find).with("37") { mock_event }
      get :show, :id => "37"
      assigns(:event).should be(mock_event)
    end
  end
end

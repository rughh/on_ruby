require 'spec_helper'

describe EventsController do
  let(:mock_data) { 'moooooooooockmockmock' }

  def mock_event(stubs={})
    (@mock_event ||= mock_model(Event).as_null_object).tap do |event|
      event.stub(stubs) unless stubs.empty?
    end
  end

  before do
    Event.stub(:preview_events) { [mock_event] }
    @controller.stub(:cache) { [mock_data] }
  end

  describe "GET :rss" do
    before { get :rss }

    it "should assign the @events to display" do
      assigns(:events).should be_an(ActiveRecord::Relation)
    end

    it "should render the :rss template" do
      response.should render_template(:rss)
    end
  end

  describe "GET :show" do
    before do
      Event.stub(:find).with("37") { mock_event }
      get :show, :id => "37"
    end

    it "should assign the requested @event" do
      assigns(:event).should be(mock_event)
    end

    it "should render the :show template" do
      response.should render_template(:show)
    end
  end

  describe "GET :info" do
    before { get :info }

    it "should render the :info template" do
      response.should render_template(:info)
    end
  end

end

require 'spec_helper'

include SpecHelper

describe EventsController do

  before do
    @event = Factory(:event)
  end

  describe "GET :rss" do
    before { get :rss }

    it "should assign the @events to display" do
      controller.events.should_not be_nil
    end

    it "should render the :rss template" do
      response.should render_template(:rss)
    end
  end

  describe "GET :show" do
    before do
      get :show, id: @event.id
    end

    it "should assign the requested @event" do
      controller.event.should eql(@event)
    end

    it "should render the :show template" do
      response.should render_template(:show)
    end
  end

end

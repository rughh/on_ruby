require 'spec_helper'

describe EventsController do
  let(:event) { create(:event) }

  context "GET :index" do
    before { get :index, format: :xml }

    it "should assign the events to display" do
      controller.events.should_not be_nil
    end

    it "should render the :index template" do
      response.headers["Content-Type"].should eql("application/xml; charset=utf-8")
      response.should render_template(:index)
    end
  end

  context "GET :show" do
    before do
      get :show, id: event.id
    end

    it "should assign the requested event" do
      controller.event.should eql(event)
    end

    it "should render the :show template" do
      response.should render_template(:show)
    end
  end
end

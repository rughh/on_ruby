require 'spec_helper'

describe EventsController do
  let(:event) { build(:event) }

  context "GET :index" do
    it "should assign the events to display" do
      get :index, format: :xml
      controller.events.should_not be_nil
    end

    it "should render the :index template" do
      get :index, format: :xml
      response.headers["Content-Type"].should eql("application/xml; charset=utf-8")
      response.should render_template(:index)
    end
  end

  context "GET :show" do
    it "should assign the requested event" do
      controller.stubs(event: event)
      get :show, id: event.id
      controller.event.should eql(event)
    end

    it "should render the :show template" do
      get :show, id: event.id
      response.should render_template(:show)
    end
  end
end

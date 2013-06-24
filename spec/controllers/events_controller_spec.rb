require 'spec_helper'

describe EventsController do
  let(:event) { build(:event) }

  context "GET :index" do
    it "assign the events and renders the template" do
      get :index
      controller.events.should_not be_nil
      response.should render_template(:index)
    end

    context "json" do
      it "renders json" do
        controller.stubs(events: [event])
        get :index, format: :json
        response.headers["Content-Type"].should eql("application/json; charset=utf-8")
        JSON.parse(response.body).should have(1).elements
      end
    end

    context "xml" do
      it "renders xml" do
        get :index, format: :xml
        response.headers["Content-Type"].should eql("application/xml; charset=utf-8")
        response.should render_template(:index)
      end
    end
  end

  context "GET :show" do
    it "assigns the event and renders the template" do
      get :show, id: event.id
      controller.events.should_not be_nil
      response.should render_template(:show)
    end

    context "json" do
      it "renders json" do
        controller.stubs(event: event)
        get :show, format: :json
        response.headers["Content-Type"].should eql("application/json; charset=utf-8")
        JSON.parse(response.body).keys.should include("id", "name")
      end
    end

    context "ics" do
      it "renders json" do
        controller.stubs(event: event)
        get :show, format: :ics
        response.headers["Content-Type"].should eql("text/calendar; charset=utf-8")
        response.body.should match("VCALENDAR")
      end
    end
  end
end

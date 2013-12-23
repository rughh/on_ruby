require 'spec_helper'

describe EventsController do
  context "GET :index" do
    let!(:event) { create(:event) }

    it "assign the events and renders the template" do
      get :index
      controller.events.first.should eql(event)
      response.should render_template(:index)
    end

    context "json" do
      it "renders json" do
        controller.stub(events: [event])
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
    let!(:event) { create(:event) }

    it "assigns the event and renders the template" do
      get :show, id: event.id
      controller.event.should eql(event)
      response.should render_template(:show)
    end

    context "json" do
      it "renders json" do
        controller.stub(event: event)
        get :show, id: event, format: :json
        response.headers["Content-Type"].should eql("application/json; charset=utf-8")
        JSON.parse(response.body).keys.should include("id", "name")
      end
    end

    context "ics" do
      it "renders json" do
        controller.stub(event: event)
        get :show, id: event, format: :ics
        response.headers["Content-Type"].should eql("text/calendar; charset=utf-8")
        response.body.should match("VCALENDAR")
      end
    end
  end
end

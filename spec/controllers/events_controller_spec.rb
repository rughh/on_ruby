require 'spec_helper'

describe EventsController do
  context "GET :index" do
    let!(:event) { create(:event) }

    it "assign the events and renders the template" do
      get :index
      expect(controller.events.first).to eql(event)
      expect(response).to render_template(:index)
    end

    context "json" do
      it "renders json" do
        controller.stub(events: [event])

        get :index, format: :json
        expect(response.headers["Content-Type"]).to eql("application/json; charset=utf-8")
        expect(JSON.parse(response.body)).to have(1).elements
      end
    end

    context "xml" do
      it "renders xml" do
        get :index, format: :xml
        expect(response.headers["Content-Type"]).to eql("application/xml; charset=utf-8")
        expect(response).to render_template(:index)
      end
    end
  end

  context "GET :show" do
    let!(:event) { create(:event) }

    it "assigns the event and renders the template" do
      get :show, id: event.id
      expect(controller.event).to eql(event)
      expect(response).to render_template(:show)
    end

    context "json" do
      it "renders json" do
        controller.stub(event: event)
        get :show, id: event, format: :json
        expect(response.headers["Content-Type"]).to eql("application/json; charset=utf-8")
        expect(JSON.parse(response.body).keys).to include("id", "name")
      end
    end

    context "ics" do
      it "renders json" do
        controller.stub(event: event)
        get :show, id: event, format: :ics
        expect(response.headers["Content-Type"]).to eql("text/calendar; charset=utf-8")
        expect(response.body).to match("VCALENDAR")
      end
    end
  end
end

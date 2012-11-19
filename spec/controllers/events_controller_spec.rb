require 'spec_helper'

describe EventsController do

  let(:event) { create(:event) }
  let(:user) { create(:user) }

  before { set_subdomain }

  describe "GET :index" do
    before { get :index, format: :xml }

    it "should assign the events to display" do
      controller.events.should_not be_nil
    end

    it "should render the :index template" do
      response.headers["Content-Type"].should eql("application/xml; charset=utf-8")
      response.should render_template(:index)
    end
  end

  describe "GET :show" do
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

  describe "POST :add_user" do
    before do
      controller.stubs(current_user: user)
    end

    it "should add a user via json post" do
      expect { post :add_user, format: :json, id: event.id }.to change(Participant, :count).by(1)
      response.status.should be(201)
    end

    it "should add a prticipant for current user" do
      expect { post :add_user, id: event.id }.to change(Participant, :count).by(1)

      flash[:notice].should_not be_nil
      response.should redirect_to(event)
    end

    context "with an already participating user" do
      before do
        user.participants.create(event: event)
      end

      it "should silently ignore the problem via json" do
        expect { post :add_user, format: :json, id: event.id }.to change(Participant, :count).by(0)

        response.status.should be(200)
      end

      it "should should alert a duplicate flash" do
        expect { post :add_user, id: event.id }.to change(Participant, :count).by(0)

        flash[:alert].should_not be_nil
        response.should redirect_to(event)
      end
    end
  end
end

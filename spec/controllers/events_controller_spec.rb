require 'spec_helper'

include SpecHelper

describe EventsController do

  before do
    @event = Factory(:event)
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
      get :show, :id => @event.id
    end

    it "should assign the requested @event" do
      assigns(:event).should eql(@event)
    end

    it "should render the :show template" do
      response.should render_template(:show)
    end
  end

  describe "GET :show, :format => :ics" do
    before do
      get :show, :id => @event.id, :format => :ics
    end

    it "should render the event as ics" do
      response.body.gsub!(/DTSTAMP:\w+/, 'DTSTAMP:20110416T214501').should == <<-ICAL
BEGIN:VCALENDAR\r
CALSCALE:GREGORIAN\r
METHOD:PUBLISH\r
PRODID:iCalendar-Ruby\r
VERSION:2.0\r
BEGIN:VEVENT\r
COMMENT:iCal Event by Hamburg on Ruby!\r
CREATED:114730\r
DESCRIPTION:MyText\r
DTEND:20101206T134730\r
DTSTAMP:20110416T214501\r
DTSTART:20101206T114730\r
CLASS:PUBLIC\r
LAST-MODIFIED:114730\r
LOCATION:Blau Mobilfunk GmbH\r
SEQUENCE:0\r
SUMMARY:Weihnachtstreffen\r
UID:http://test.host/events/1\r
URL:http://test.host/events/1\r
END:VEVENT\r
END:VCALENDAR\r
      ICAL
    end
  end

  describe "GET :publish" do
    before do
      Event.any_instance.stubs(:publish! => nil)
    end

    context "for unauthorized users" do
      before do
        get :publish, :id => @event.id
      end

      it "publishing should fail" do
        flash[:alert].should_not be_nil
        response.should redirect_to(root_path)
      end
    end

    context "for unpublished event" do
      before do
        @unpublished_event = Factory(:event, :published => false)
        controller.stubs(:current_user => admin_user)
        get :publish, :id => @unpublished_event.id
      end

      it "should publish the event for admin" do
        response.should redirect_to(events_path)
        flash[:notice].should_not be_nil
      end
    end

    context "for published event" do
      before do
        @published_event = Factory(:event, :published => true)
        controller.stubs(:current_user => admin_user)
        get :publish, :id => @published_event.id
      end

      it "should raise an error" do
        response.should redirect_to(events_path)
        flash[:alert].should_not be_nil
      end
    end
  end

end

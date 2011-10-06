require 'spec_helper' 

describe EventsController do

  let(:event) { Factory(:event) }
  let(:user) { Factory(:user) }

  describe "GET :rss" do
    before { get :rss, format: :xml }

    it "should assign the events to display" do
      controller.events.should_not be_nil
    end

    it "should render the :rss template" do
      response.should render_template(:rss)
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
    it "should add a prticipant for current user" do
      controller.stubs(current_user: user)

      expect { post :add_user, id: event.id }.to change(Participant, :count).by(1)

      flash[:notice].should_not be_nil
      response.should redirect_to(event)
    end

    it "should should not add paritcipant if already exists" do
      user.participants.create(event: event)
      controller.stubs(current_user: user)

      expect { post :add_user, id: event.id }.to change(Participant, :count).by(0)

      flash[:alert].should_not be_nil
      response.should redirect_to(event)
    end
  end

end

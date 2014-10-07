require 'spec_helper'

describe Admin::EventsController do
  it "handles authentication" do
    get :index
    expect(response).to redirect_to(root_path)
    expect(flash[:alert]).to eql("Hoppala, da dürfen nur Admins hin!")
  end

  context "as admin" do
    before do
      controller.stub(current_user: build(:admin_user))
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end

    context "GET :duplicate" do
      it "duplicates the last event" do
        create(:event)
        expect { get :duplicate }.to change(Event, :count).by(1)
      end
    end

    context "GET :publish" do
      it "duplicates the last event" do
        event = create(:event)

        allow(ZeroPush).to recieve(:brodacast).with({
          channel: 'hamburg',
          alert: "[Hamburg]: new event at #{I18n.l(event.date)}",
          content_available: true
        })

        expect {
          get :publish, id: event.id
        }.to change {
          ActionMailer::Base.deliveries.size
        }.by(1)
      end
    end
  end
end

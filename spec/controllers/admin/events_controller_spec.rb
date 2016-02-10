require 'spec_helper'

describe Admin::EventsController do
  it "handles authentication" do
    get :index
    expect(response).to redirect_to(root_path)
    expect(flash[:alert]).to eql("Hoppala, da dürfen nur Admins hin!")
  end

  context "as admin" do
    before do
      allow(controller).to receive_messages(current_user: build(:admin_user))
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
      it "publish the event" do
        event = create(:event)

        expect {
          get :publish, id: event.id
        }.to change {
          ActionMailer::Base.deliveries.size
        }.by(1)
      end
    end

    context "GET :send_ios_push_notification" do
      it "send notification with zeropush" do
        event = create(:event)

        expect(OneSignal::Notification).to receive(:create).with({
          params: {
            app_id: nil,
            included_segments: [Whitelabel[:label_id]],
            contents: {
              en: "#{I18n.tw("name")}: new event at #{I18n.l(event.date)}"
            },
            content_available: true
          }
        }).and_return(OpenStruct.new(code: '200'))

        get :send_ios_push_notification, id: event.id
      end
    end
  end
end

require 'spec_helper'

describe Admin::HighlightsController do
  context 'as admin' do
    before do
      allow(controller).to receive_messages(current_user: build(:admin_user))
    end

    context 'GET :duplicate' do
      let(:highlight) { create(:highlight) }

      it 'duplicates the last event' do
        get :disable, id: highlight
        expect(assigns[:highlight]).to be_disabled
      end
    end
  end
end

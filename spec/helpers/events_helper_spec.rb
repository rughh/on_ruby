require 'spec_helper'

describe EventsHelper do
  let(:event) { create(:event) }
  let(:participant) { create(:participant, user: event.user) }
  let(:participation_event) { create(:event, participants: [participant]) }

  context 'signed_in user' do
    before do
      allow(helper).to receive_messages(signed_in?: true, current_user: event.user)
    end

    describe '#participation_link' do
      it 'renders a paritcipate button' do
        expect(helper.participation_link(event)).to match('Teilnehmen')
      end

      it 'disbales the button on closed events' do
        event = build(:closed_event)
        expect(helper.participation_link(event)).to match('data-disable')
      end

      it 'renders a cancel button' do
        expect(helper.participation_link(participation_event)).to match('Absagen')
      end
    end
  end

  context 'anonymous visitor' do
    before do
      allow(helper).to receive(:signed_in?).and_return(false)
      allow(helper.request).to receive(:path).and_return('/events/23')
    end

    describe '#participation_link' do
      it 'links to the login page and carries the current path as the origin' do
        expect(helper.participation_link(event))
          .to have_link(I18n.t('show.attend'), href: login_path(origin: '/events/23'))
      end
    end
  end
end

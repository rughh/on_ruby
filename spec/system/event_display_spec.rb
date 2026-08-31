require 'spec_helper'

RSpec.describe 'Event detail page', type: :system do
  before do
    driven_by :rack_test
    Capybara.app_host = 'http://hamburg.onruby.de'
  end

  let(:organizer) { create(:user, name: 'Olive Organizer') }
  let(:location)  { create(:location, name: 'Betahaus Hamburg') }
  let(:event) do
    create(
      :event,
      user: organizer,
      location: location,
      name: 'Ruby Meetup #42',
      description: 'A talk about pattern matching and more.',
      date: 1.month.from_now.change(hour: 19, min: 0)
    )
  end

  describe 'event details' do
    it 'shows the title, description, date, host and location' do
      visit event_path(event)

      expect(page).to have_css('h2', text: 'Ruby Meetup #42')
      expect(page).to have_content('A talk about pattern matching and more.')
      expect(page).to have_content(I18n.l(event.date, format: :long))
      expect(page).to have_link('Olive Organizer')
      expect(page).to have_link('Betahaus Hamburg')
      expect(page).to have_css('h3', text: I18n.t('show.route')) # map section for a physical venue
    end

    it 'omits the location entirely when the event has none' do
      event.update!(location: nil)

      visit event_path(event)

      expect(page).to have_css('h2', text: 'Ruby Meetup #42')
      expect(page).to have_no_link('Betahaus Hamburg')
      expect(page).to have_no_css('h3', text: I18n.t('show.route'))
    end

    it 'names a virtual location but renders no route/map section' do
      event.update!(location: create(:virtual_location, name: 'Jitsi Room'))

      visit event_path(event)

      expect(page).to have_link('Jitsi Room')
      expect(page).to have_no_css('h3', text: I18n.t('show.route'))
    end

    it 'hides attendee information from anonymous visitors' do
      event.update!(attendee_information: 'Door code is 1234')

      visit event_path(event)

      expect(page).to have_no_content('Door code is 1234')
      expect(page).to have_content(I18n.t('show.attend_to_view_attendees_information'))
    end

    it 'returns 404 for an event belonging to another usergroup' do
      other_label = Whitelabel.labels.last
      foreign_event = Whitelabel.with_label(other_label) { create(:event, label: other_label.label_id) }

      visit event_path(foreign_event)

      expect(page.status_code).to eq(404)
    end
  end

  describe 'associated topics' do
    it 'renders the topics attached to the event' do
      create(:topic, event: event, name: 'Pattern matching deep dive', description: 'case/in in practice')

      visit event_path(event)

      expect(page).to have_css('h3', text: I18n.t('main.topics'))
      expect(page).to have_link('Pattern matching deep dive')
      expect(page).to have_content('case/in in practice')
    end

    it 'does not render topics from other events or unassigned proposals' do
      create(:proposal, name: 'Unassigned proposal')
      create(:topic, name: 'Other event topic')

      visit event_path(event)

      expect(page).to have_no_css('h3', text: I18n.t('main.topics'))
      expect(page).to have_no_content('Unassigned proposal')
      expect(page).to have_no_content('Other event topic')
    end
  end

  describe 'participant list' do
    # heading text is "Teilnehmerinnen und Teilnehmer (<count>)"; locale is pinned to :de in spec_helper
    let(:attendees_heading) { I18n.t('show.attendees', count: 0, participant_count: 0).sub(/\s*\(.*\)\z/, '') }

    it 'lists users who have RSVPed and no one else' do
      create(:participant, event: event, user: create(:user, name: 'Rsvp Rita'))
      create(:user, name: 'Absent Alice')

      visit event_path(event)

      expect(page).to have_css('h3', text: attendees_heading)
      expect(page).to have_content('Rsvp Rita')
      expect(page).to have_no_content('Absent Alice')
    end

    it 'shows no attendee section when nobody has RSVPed' do
      visit event_path(event)

      expect(page).to have_no_css('h3', text: attendees_heading)
    end
  end
end

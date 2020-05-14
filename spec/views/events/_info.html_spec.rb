require 'spec_helper'

RSpec.describe 'events/show' do
  let(:user) { nil }

  before do
    allow(view).to receive(:signed_in?).and_return(user.present?)
    allow(view).to receive(:current_user).and_return(user)
  end

  it 'should display the title' do
    event = build(:event, name: 'example title')

    render partial: 'info', locals: { event: event }

    expect(rendered).to match('example title')
  end

  it 'should display the description' do
    event = build(:event, description: 'example desciption')

    render partial: 'info', locals: { event: event }

    expect(rendered).to match('example desciption')
  end

  it 'should display the event organisator' do
    organisator = build(:user, name: 'John doe')
    event = build(:event, user: organisator)

    render partial: 'info', locals: { event: event }

    expect(rendered).to match(organisator.name)
  end

  it 'should display the event time' do
    time = Time.zone.parse('2020-05-14 20:00:00')
    event = build(:event, date: time)

    render partial: 'info', locals: { event: event }

    expect(rendered).to match(I18n.l(time, format: :long))
  end

  describe 'location' do
    context 'when location present' do
      let(:location) { build(:location, name: 'example location') }

      it 'should display the event location name' do
        event = build(:event, location: location)

        render partial: 'info', locals: { event: event }

        expect(rendered).to match('example location')
      end

      it 'should display the event location link' do
        event = build(:event, location: location)

        render partial: 'info', locals: { event: event }

        expect(rendered).to have_tag('a')
      end
    end

    context 'when location is not present' do
      let(:location) { nil }

      it 'should display the event location name' do
        event = build(:event, location: location)

        render partial: 'info', locals: { event: event }

        expect(rendered).not_to match('example location')
      end
    end
  end
end
require 'spec_helper'

# Browser-facing walk-through of the administrate dashboard. Fine-grained CRUD
# and authorization assertions live in spec/requests/admin/*; this file exercises
# the real forms with semantic selectors so it survives CSS/markup churn.
#
# Deletion is intentionally not covered here: the custom
# app/views/admin/events/_collection.html.erb renders the destroy control as a
# `link_to ... method: :delete` (rails-ujs), which needs JavaScript. The suite
# runs on :rack_test, so destroy is verified in spec/requests/admin instead.
RSpec.describe 'Admin management', type: :system do
  before do
    driven_by :rack_test
    Capybara.app_host = 'http://hamburg.onruby.de'
  end

  it 'keeps signed-in non-admins out of the dashboard' do
    sign_in_through_ui

    visit '/admin'

    expect(page).to have_current_path('/')
    expect(page).to have_content(I18n.t('flash.only_admins'))
  end

  it 'lets an admin create and then edit an event' do
    organizer = create(:user, name: 'Olive Organizer')
    create(:location, name: 'Betahaus Hamburg')
    sign_in_through_ui(admin: true)

    visit '/admin/events/new'
    fill_in 'Name', with: 'Capybara Meetup'
    fill_in 'Description', with: 'Walking the admin UI end to end'
    fill_in 'Date', with: 1.month.from_now.change(hour: 18, min: 0).strftime('%Y-%m-%dT%H:%M')
    select 'Olive Organizer', from: 'User'
    select 'Betahaus Hamburg', from: 'Location'
    find('input[type="submit"]').click

    expect(page).to have_content('Capybara Meetup')
    event = Event.find_by!(name: 'Capybara Meetup')
    expect(event.user).to eq(organizer)

    visit edit_admin_event_path(event)
    fill_in 'Name', with: 'Capybara Meetup (updated)'
    find('input[type="submit"]').click

    expect(page).to have_content('Capybara Meetup (updated)')
    expect(event.reload.name).to eq('Capybara Meetup (updated)')
  end

  it 'lets an admin create a location flagged as a company' do
    sign_in_through_ui(admin: true)

    visit '/admin/locations/new'
    fill_in 'Name', with: 'Acme Inc'
    fill_in 'Url', with: 'https://acme.example'
    check 'Company'
    fill_in 'Street', with: 'Eifflerstraße'
    fill_in 'House number', with: '43'
    fill_in 'City', with: 'Hamburg'
    fill_in 'Zip', with: '22769'
    find('input[type="submit"]').click

    expect(page).to have_content('Acme Inc')
    expect(Location.find_by!(name: 'Acme Inc')).to be_company
  end
end

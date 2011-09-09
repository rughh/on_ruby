# encoding: utf-8
require 'spec_helper'

feature "Home", %q{
  In order to have a functional page
  As a user
  I want to access all possible pages
} do

  background do
    @future_event = Factory(:event, date: 2.days.since)
  end

  scenario "index" do
    visit '/'
    page.should have_content("Das nächste Treffen")
    page.should have_content("bei Blau Mobilfunk GmbH statt!")
  end

end


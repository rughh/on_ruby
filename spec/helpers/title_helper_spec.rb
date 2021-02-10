require 'spec_helper'

describe TitleHelper do
  describe '#page_title' do
    it 'generates a page_title' do
      expect(helper.page_title).to eql('Hamburg on Ruby - Heimathafen der Hamburger Ruby Community')
    end

    it 'generates a page_title for a user page' do
      allow(helper).to receive_messages(controller_name: 'users', action_name: 'show', user: build(:user, name: 'uschi'))

      expect(helper.page_title).to eql('Hamburg on Ruby - uschi')
    end

    it 'has a page_title for default label' do
      Whitelabel.reset!

      expect(helper.page_title).to eql('OnRuby - Die Ruby und Rails Usergroup Plattform - Ruby / Rails Communities Deutschland')
    end
  end
end

require 'spec_helper'

describe ExternalLinkHelper do
  let(:user) { build(:user) }

  context '#link_to_github' do
    it 'should generate the link' do
      user = build(:user, github: 'giddiup')
      expect(helper.link_to_github(user)).to eql('<a title="giddiup" href="http://github.com/giddiup">giddiup</a>')
    end

    it 'should generate the link with a block' do
      user = build(:user, github: 'giddiup')
      expect(helper.link_to_github(user) { 'uschi' }).to eql('<a title="giddiup" href="http://github.com/giddiup">uschi</a>')
    end

    it 'should render nothing for no github' do
      user.github = nil
      expect(helper.link_to_github(user)).to be_nil
    end
  end

  context '#mailing_list_entries' do
    it 'fetches and parses a feed' do
      expect(mailing_list_entries).to have(15).items
    end
  end

  context '#mailing_list_url' do
    it 'creates an url' do
      expect(helper.mailing_list_url).to eql('https://groups.google.com/group/rubyonrails-ug-germany')
      Whitelabel.with_label(Whitelabel.label_for('cologne')) do
        expect(helper.mailing_list_url).to eql('https://groups.google.com/group/colognerb')
      end
    end
  end

  context '#link_to_twitter' do
    it 'should generate the link' do
      user = build(:user, twitter: 'klaus')
      expect(helper.link_to_twitter(user)).to eql('@<a title="klaus" href="http://twitter.com/klaus">klaus</a>')
    end
  end

  context '#twitter_update_url' do
    let(:topic) { create(:topic, name: 'bla') }
    let(:event) { create(:event, name: 'Weihnachtstreffen', date: '2010-12-06 11:47:30') }

    it 'should generate a proper url for topics' do
      topic.user.name = 'Uschi'

      url = helper.twitter_update_url(topic)
      expect(url).to match(Regexp.escape('http://twitter.com/home?status=Neues%20Thema%20von%20@Uschi'))
      expect(url).to match(Regexp.escape('http://test.host/topics/bla'))
    end

    it 'should generate a proper url for events' do
      url = helper.twitter_update_url(event)
      expect(url).to match(Regexp.escape('http://twitter.com/home?status=Weihnachtstreffen'))
      expect(url).to match(Regexp.escape('am%2006.%20Dezember,%2011:47%20Uhr'))
      expect(url).to match(Regexp.escape('http://test.host/events/weihnachtstreffen'))
    end
  end
end

require 'spec_helper'

describe ExternalLinkHelper do
  let(:user) { build(:user) }

  describe '#link_to_github' do
    it 'generates the link' do
      user = build(:user, github: 'giddiup')
      expect(helper.link_to_github(user)).to eql('<a title="giddiup" href="https://github.com/giddiup">giddiup</a>')
    end

    it 'generates the link with a block' do
      user = build(:user, github: 'giddiup')
      expect(helper.link_to_github(user) { 'uschi' }).to eql('<a title="giddiup" href="https://github.com/giddiup">uschi</a>')
    end

    it 'renders nothing for no github' do
      user.github = nil
      expect(helper.link_to_github(user)).to be_nil
    end

    it 'generates proper github urls' do
      expect(helper.github_issue_url(123)).to eql('https://github.com/rughh/planning/issues/123')
    end
  end

  describe '#link_to_linkedin' do
    it 'generates the link' do
      user = build(:user, linkedin: 'testyin')
      expect(helper.link_to_linkedin(user)).to eql('<a title="testyin" href="https://www.linkedin.com/in/testyin">testyin</a>')
    end

    it 'generates the link with a block' do
      user = build(:user, linkedin: 'testyin')
      expect(helper.link_to_linkedin(user) { 'testyin' }).to eql('<a title="testyin" href="https://www.linkedin.com/in/testyin">testyin</a>')
    end

    it 'renders nothing for no linkedin' do
      user.linkedin = nil
      expect(helper.link_to_linkedin(user)).to be_nil
    end
  end

  describe '#mailing_list_url' do
    let(:colognerb) { Usergroup.from_name('colognerb').tap { _1.recurring = 'thrid wednesday' } }

    it 'creates an url' do
      expect(helper.mailing_list_url).to eql('https://groups.google.com/group/rubyonrails-ug-germany')
      Whitelabel.with_label(colognerb) do
        expect(helper.mailing_list_url).to eql('https://groups.google.com/group/colognerb')
      end
    end
  end
end

require 'spec_helper'

describe User do
  context 'validation' do
    let(:user) { build(:user) }
    let(:admin_user) { build(:admin_user) }

    it 'allows empty and nil github and twitter keys for all' do
      create(:user, github: '', twitter: '')
      expect do
        create(:user, github: '', twitter: '')
      end.not_to raise_error
    end

    it 'allows names and nothing on github' do
      ['abc', 'hanno-nym', '111bbb888_', nil, ''].each do |val|
        user.github = val
        expect(user).to have(0).errors_on(:github)
      end
    end

    it 'does not allow urls on github' do
      ['http://', 'www.bla'].each do |val|
        user.github = val
        expect(user).to have(1).errors_on(:github)
      end
    end

    it 'authorizes phoet as admin' do
      expect(admin_user.admin?).to be(true)
    end
  end

  context 'auth' do
    let(:user) { create(:user) }

    context 'regressions' do
      let(:github_auth_missing_params) do
        { 'provider' => 'github', 'uid' => '213249', 'info' => { 'nickname' => 'lukas2', 'email' => nil, 'name' => '', 'image' => 'image', 'urls' => { 'GitHub' => 'https://github.com/lukas2', 'Blog' => nil } }, 'extra' => { 'raw_info' => { 'type' => 'User', 'html_url' => 'https://github.com/lukas2', 'email' => nil, 'public_gists' => 6, 'location' => 'Munich', 'company' => nil, 'public_repos' => 18, 'following' => 11, 'blog' => nil, 'hireable' => false, 'login' => 'lukas2', 'name' => '', 'created_at' => '2010-03-01T16:39:16Z', 'bio' => nil, 'id' => 213_249, 'followers' => 6 } } }
      end

      it 'handles missing params' do
        expect do
          User.create_from_hash!(github_auth_missing_params)
        end.to change(User, :count).by(1)
      end
    end

    it 'creates a user from an outh-hash' do
      expect do
        User.create_from_hash!(TWITTER_AUTH_HASH)
      end.to change(User, :count).by(1)
    end

    it 'adds email addresses for github users' do
      user = User.create_from_hash!(GITHUB_AUTH_HASH)
      expect(user.email).to eql('phoetmail@googlemail.com')
    end

    it 'sets email and empty name for users created by email' do
      user = User.create_from_hash!(EMAIL_AUTH_HASH)
      expect(user.email).to eql('user@somewhere.org')
      expect(user.name).to eql(User::EMPTY_NAME)
    end

    it 'raises an error for same nickname but different auths' do
      User.create_from_hash!(TWITTER_AUTH_HASH)
      expect do
        User.create_from_hash!(GITHUB_AUTH_HASH)
      end.to raise_error(User::DuplicateNickname)
    end

    it 'updates a user from twitter-auth-hash' do
      user.update_from_auth!(TWITTER_AUTH_HASH).tap do |it|
        expect(it.name).to eql('Peter Schröder')
        expect(it.twitter).to eql('phoet')
        expect(it.location).to eql('Sternschanze, Hamburg')
        expect(it.image).to eql('http://a3.twimg.com/profile_images/1100439667/P1040913_normal.JPG')
        expect(it.description).to eql('I am a freelance Ruby and Java developer from Hamburg, Germany. ☠ nofail')
        expect(it.url).to eql('http://nofail.de')
      end
    end

    it 'updates a user from github-auth-hash' do
      user.update_from_auth!(GITHUB_AUTH_HASH).tap do |it|
        expect(it.name).to eql('Peter Schröder')
        expect(it.github).to eql('phoet')
        expect(it.location).to eql('Hamburg, Germany')
        expect(it.image).to eql('https://secure.gravatar.com/avatar/056c32203f8017f075ac060069823b66?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png')
        expect(it.description).to match('My name is')
        expect(it.url).to eql('http://blog.nofail.de')
      end
    end

    it 'updates only the email from email-auth-hash', :aggregate_failures do
      expect { user.update_from_auth!(EMAIL_AUTH_HASH) }
        .not_to(change { user.attributes.slice(:name, :github, :image, :location, :description, :url) })
      expect(user.email).to eq('user@somewhere.org')
    end
  end

  context 'finder' do
    let(:event) { create(:event) }
    let(:user) { create(:user) }
    let(:admin_user) { create(:admin_user) }

    it 'finds peers' do
      create_list(:event_with_participants, 3)
      expect(User).to have(9).peers
    end

    it 'does not find peers from different labels' do
      create(:event_with_participants)
      Whitelabel.with_label(Whitelabel.labels.last) do
        create(:event_with_participants)
      end
      expect(User).to have(3).peers
    end

    it 'participate?s' do
      expect do
        admin_user.participants.create!(event:, user: admin_user)
      end.to change {
        admin_user.participates?(event)
      }.from(false).to(true)
    end

    it 'finds the participation' do
      admin_user.participants.create!(event:, user: admin_user)
      expect(admin_user.participation(event)).not_to be_nil
    end
  end
end

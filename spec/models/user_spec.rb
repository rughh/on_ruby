# encoding: UTF-8
require 'spec_helper'

describe User do
  context "validation" do

    let(:user) { build(:user) }
    let(:admin_user) { build(:admin_user) }

    it "should allow names and nothing on github" do
      ["abc", "hanno-nym", "111bbb888_", nil, ""].each do |val|
        user.github = val
        user.should have(0).errors_on(:github)
      end
    end

    it "should not allow urls on github" do
      ["http://", "www.bla"].each do |val|
        user.github = val
        user.should have(1).errors_on(:github)
      end
    end

    it "should authorize phoet as admin" do
      admin_user.admin?.should be(true)
    end
  end

  context "auth" do
    let(:user) { create(:user) }

    context "regressions" do
      let(:github_auth_missing_params) do
        {"provider"=>"github", "uid"=>"213249", "info"=>{"nickname"=>"lukas2", "email"=>nil, "name"=>"", "image"=>"image", "urls"=>{"GitHub"=>"https://github.com/lukas2", "Blog"=>nil}}, "extra"=>{"raw_info"=>{"type"=>"User", "html_url"=>"https://github.com/lukas2", "email"=>nil, "public_gists"=>6, "location"=>"Munich", "company"=>nil, "public_repos"=>18, "following"=>11, "blog"=>nil, "hireable"=>false, "login"=>"lukas2", "name"=>"", "created_at"=>"2010-03-01T16:39:16Z", "bio"=>nil, "id"=>213249, "followers"=>6}}}
      end

      it "should handle missing params" do
        expect do
          User.find_or_create_from_hash!(github_auth_missing_params)
        end.to change(User, :count).by(1)
      end
    end

    it "should create a user from an outh-hash" do
      expect do
        User.find_or_create_from_hash!(TWITTER_AUTH_HASH)
      end.to change(User, :count).by(1)
    end

    it "should create not create a new user for same nickname" do
      tu = User.find_or_create_from_hash!(TWITTER_AUTH_HASH)
      gu = User.find_or_create_from_hash!(GITHUB_AUTH_HASH)
      tu.id.should eql(gu.id)
    end

    it "should update a user from twitter-auth-hash" do
      user.update_from_auth!(TWITTER_AUTH_HASH).tap do |it|
        it.name.should eql('Peter Schröder')
        it.location.should eql('Sternschanze, Hamburg')
        it.image.should eql('http://a3.twimg.com/profile_images/1100439667/P1040913_normal.JPG')
        it.description.should eql('I am a freelance Ruby and Java developer from Hamburg, Germany. ☠ nofail')
        it.url.should eql('http://nofail.de')
      end
    end

    it "should update a user from github-auth-hash" do
      user.update_from_auth!(GITHUB_AUTH_HASH).tap do |it|
        it.name.should eql('Peter Schröder')
        it.location.should eql('Hamburg, Germany')
        it.image.should eql('https://secure.gravatar.com/avatar/056c32203f8017f075ac060069823b66?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png')
        it.description.should match('My name is')
        it.url.should eql('http://blog.nofail.de')
      end
    end
  end

  context "finder" do
    let(:event) { create(:event) }
    let(:user) { create(:user) }
    let(:admin_user) { create(:admin_user) }

    it "should find and transform usernames for semanticform" do
      %w(uschi klaus mauro).each { |name| create(:user, name: name, nickname: "nick_#{name}") }
      User.all_for_selections.should eql([
        ["klaus (nick_klaus)", 2],
        ["mauro (nick_mauro)", 3],
        ["uschi (nick_uschi)", 1]
      ])
    end

    it "should find peers" do
      3.times { create(:event_with_participants) }
      User.peers.should have(3).elements
    end

    it "should not find peers from different labels" do
      create(:event_with_participants)
      Whitelabel.with_label(Whitelabel.labels.last) do
        create(:event_with_participants)
      end
      User.peers.should have(1).elements
    end

    it "should participate?" do
      admin_user.participates?(event).should be(false)
      admin_user.participants.create!(event: event, user: admin_user)
      admin_user.participates?(event).should be(true)
    end

    it "should find the participation" do
      admin_user.participants.create!(event: event, user: admin_user)
      admin_user.participation(event).should_not be_nil
    end

    it "should select random users" do
      10.times {|i| create(:user, nickname: "phoet#{i}")}
      users = User.random(5)
      users.size.should be(5)
      users.map(&:nickname).to_s.should_not be(User.random(5).map(&:nickname))
    end
  end
end

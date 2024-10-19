require 'spec_helper'

describe Authorization do
  it 'creates an auth and a user from an auth-hash' do
    expect do
      expect do
        Authorization.handle_authorization(nil, TWITTER_AUTH_HASH)
      end.to change(User, :count).by(1)
    end.to change(Authorization, :count).by(1)
  end

  describe 'special treatment for stale Twitter users' do
    let(:existing_twitter_auth) { Authorization.handle_authorization(nil, TWITTER_AUTH_HASH) }
    let(:existing_twitter_user) { existing_twitter_auth.user }

    before { existing_twitter_user }

    context 'when emails do not match', :aggregate_failures do
      context 'when nicknames are the same' do
        it 'raises duplication error' do
          expect do
            Authorization.handle_authorization(nil, GITHUB_AUTH_HASH)
          end.to raise_error(User::DuplicateNickname)
        end
      end

      context 'when nicknames are different' do
        before { existing_twitter_user.update!(nickname: existing_twitter_user.nickname * 2) }

        it 'creates a new user' do
          gh_user = Authorization.handle_authorization(nil, GITHUB_AUTH_HASH).user
          expect(gh_user).to be_persisted
          expect(gh_user).not_to eq(existing_twitter_user)
        end
      end
    end

    context 'when emails match' do
      before { existing_twitter_user.update!(email: GITHUB_AUTH_HASH.dig('info', 'email')) }

      context 'when email is unique and user has only Twiter auth' do
        it 'adds the auth to the existing Twitter account', :aggregate_failures do
          gh_auth = Authorization.handle_authorization(nil, GITHUB_AUTH_HASH)
          expect(gh_auth.user).to eq(existing_twitter_user)
          expect(existing_twitter_user.reload.github).to eq(GITHUB_AUTH_HASH.dig('info', 'nickname'))
        end
      end

      context 'when several users have the same email' do
        before { create(:user, email: existing_twitter_user.email) }

        it 'raises duplication error' do
          expect do
            Authorization.handle_authorization(nil, GITHUB_AUTH_HASH)
          end.to raise_error(User::DuplicateNickname)
        end
      end

      context 'when the user has other authorizations' do
        before { create(:authorization, user: existing_twitter_user) }

        it 'raises duplication error' do
          expect do
            Authorization.handle_authorization(nil, GITHUB_AUTH_HASH)
          end.to raise_error(User::DuplicateNickname)
        end
      end

      context 'when the user had a single auth but it was not Twitter' do
        before { existing_twitter_user.authorizations = [create(:authorization)] }

        it 'raises duplication error' do
          expect do
            Authorization.handle_authorization(nil, GITHUB_AUTH_HASH)
          end.to raise_error(User::DuplicateNickname)
        end
      end
    end
  end
end

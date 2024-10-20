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
    let(:new_auth_hash) { GITHUB_AUTH_HASH }
    let(:date_of_test) { Authorization::DEFAULT_TWITTER_USER_FALLBACK_DEADLINE - 1 }

    around do |example|
      travel_to(date_of_test) do
        example.run
      end
    end

    shared_examples 'failing with duplicate nickname' do
      it 'raises duplication error' do
        expect do
          Authorization.handle_authorization(nil, new_auth_hash)
        end.to raise_error(User::DuplicateNickname)
      end
    end

    shared_examples 'updating the existing user' do
      it 'adds the auth to the existing Twitter account', :aggregate_failures do
        gh_auth = Authorization.handle_authorization(nil, new_auth_hash)
        expect(gh_auth.user).to eq(existing_twitter_user)
        expect(existing_twitter_user.reload.github).to eq(new_auth_hash.dig('info', 'nickname'))
      end
    end

    before do
      existing_twitter_user
      create(:authorization, provider: 'twitter', user: create(:user, email: nil))
    end

    context 'when emails do not match' do
      context 'when nicknames are the same' do
        it_behaves_like 'failing with duplicate nickname'
      end

      context 'when nicknames are different' do
        before { existing_twitter_user.update!(nickname: existing_twitter_user.nickname * 2) }

        it 'creates a new user', :aggregate_failures do
          gh_user = Authorization.handle_authorization(nil, new_auth_hash).user
          expect(gh_user).to be_persisted
          expect(gh_user).not_to eq(existing_twitter_user)
        end
      end
    end

    context 'when emails match' do
      before { existing_twitter_user.update!(email: new_auth_hash.dig('info', 'email')) }

      context 'when email is unique and user has only Twiter auth' do
        around do |example|
          value_before = ENV['TWITTER_USER_FALLBACK_DEADLINE']
          ENV['TWITTER_USER_FALLBACK_DEADLINE'] = deadline_value
          example.run
          ENV['TWITTER_USER_FALLBACK_DEADLINE'] = value_before
        end

        shared_examples 'updating the user before the deadline, failing afterwards' do
          context 'before the deadline' do
            let(:date_of_test) { effective_deadline - 1 }

            it_behaves_like 'updating the existing user'
          end

          context 'with a valid value and after that deadline' do
            let(:date_of_test) { effective_deadline + 1 }

            it_behaves_like 'failing with duplicate nickname'
          end
        end

        context 'with no explicit deadline' do
          let(:deadline_value) { nil }
          let(:effective_deadline) { Authorization::DEFAULT_TWITTER_USER_FALLBACK_DEADLINE }

          it_behaves_like 'updating the user before the deadline, failing afterwards'
        end

        context 'with a valid explicit deadline' do
          let(:deadline_value) { '2026-01-01' }
          let(:effective_deadline) { Date.parse('2026-01-01') }

          it_behaves_like 'updating the user before the deadline, failing afterwards'
        end

        context 'with an invalid explicit deadline' do
          let(:deadline_value) { 'bad date!' }
          let(:effective_deadline) { Authorization::DEFAULT_TWITTER_USER_FALLBACK_DEADLINE }

          it_behaves_like 'updating the user before the deadline, failing afterwards'
        end
      end

      context 'when several users have the same email' do
        before { create(:user, email: existing_twitter_user.email) }

        it_behaves_like 'failing with duplicate nickname'
      end

      context 'when the user has other authorizations' do
        before { create(:authorization, user: existing_twitter_user) }

        it_behaves_like 'failing with duplicate nickname'
      end

      context 'when the user has a single auth but it is not Twitter' do
        before { existing_twitter_user.authorizations = [create(:authorization)] }

        it_behaves_like 'failing with duplicate nickname'
      end
    end

    context 'when new auth has no email' do
      let(:new_auth_hash) { GITHUB_AUTH_HASH.deep_merge('info' => { 'email' => nil }) }

      it_behaves_like 'failing with duplicate nickname'
    end
  end
end

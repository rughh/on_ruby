# frozen_string_literal: true

class Authorization < ApplicationRecord
  belongs_to :user

  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: { scope: :provider }

  def self.handle_authorization(existing_user, auth)
    provider = auth['provider']
    uid      = auth['uid']

    authorization = find_by(provider:, uid:)
    if authorization.present?
      authorization.user.update_from_auth! auth
    else
      user = existing_user || fallback_user_for_authorization(auth) || User.create_from_hash!(auth)
      authorization = user.authorizations.create! provider:, uid:
    end
    authorization
  end

  def self.fallback_user_for_authorization(auth)
    return unless user_fallback_in_place?

    email = auth.dig('info', 'email')
    return if email.blank?

    users_with_email = User.where(email:)
    return unless users_with_email.count == 1

    user = users_with_email.first
    return nil unless user.authorizations.count == 1 && user.authorizations.first.provider == 'twitter'

    user.update_from_auth!(auth)
  end

  DEFAULT_TWITTER_USER_FALLBACK_DEADLINE = Date.new(2025, 1, 1)

  def self.user_fallback_in_place?
    deadline = begin
      Date.parse(ENV['TWITTER_USER_FALLBACK_DEADLINE'])
    rescue Date::Error, TypeError
      DEFAULT_TWITTER_USER_FALLBACK_DEADLINE
    end
    deadline.future?
  end
end

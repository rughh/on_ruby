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
      user = existing_user || user_for_new_authorization(auth) || User.create_from_hash!(auth)
      authorization = user.authorizations.create! provider:, uid:
    end
    authorization
  end

  def self.user_for_new_authorization(auth)
    email = auth.dig('info', 'email')
    users_with_email = User.where(email:)
    return unless users_with_email.count == 1

    user = users_with_email.first
    return nil unless user.authorizations.count == 1 && user.authorizations.first.provider == 'twitter'

    user.update_from_auth!(auth)
  end
end

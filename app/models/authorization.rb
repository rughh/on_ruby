class Authorization < ApplicationRecord
  belongs_to :user

  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: { scope: :provider }

  def self.handle_authorization(auth)
    provider = auth['provider']
    uid = auth['uid']

    authorization = find_by_provider_and_uid provider, uid
    if authorization.present?
      authorization.user.update_from_auth! auth
    else
      user = User.find_or_create_from_hash! auth
      authorization = Authorization.create! user: user, provider: provider, uid: uid
    end
    authorization
  end
end

class Authorization < ActiveRecord::Base
  belongs_to :user

  validates :user_id, :uid, :provider, presence: true
  validates :uid, uniqueness: { scope: :provider }

  attr_accessible :user, :uid, :provider

  def self.handle_authorization(auth)
    provider = auth['provider']
    uid      = auth['uid']

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

# Helpers for signing users in through the real authentication stack.
#
# The app has no `Devise`-style test helper and the custom `UserHandling`
# concern reads `current_user` from the session/cookies, so specs that exercise
# the full HTTP stack (request and system specs) cannot stub `current_user` the
# way controller specs do. Instead we drive the OmniAuth callback to establish a
# genuine session.
module AuthenticationHelper
  def mock_github_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(GITHUB_AUTH_HASH)
  end

  # Request specs: hit the OmniAuth callback directly. The resulting session
  # cookie is reused by every following request in the same example. Creates a
  # brand new user from GITHUB_AUTH_HASH.
  def sign_in_via_github(admin: false, super_admin: false)
    mock_github_omniauth
    get '/auth/github/callback'
    promote(github_user, admin:, super_admin:)
  end

  # Request specs: sign in as a specific, existing User record. Goes through the
  # real callback via google_oauth2 -- its attribute mapper only reads
  # info.{name,email,image}, so passing the user's own values makes
  # `update_from_auth!` a no-op (nothing is mutated).
  def login_as(user)
    uid = "test-#{user.id}"
    create(:authorization, user:, provider: 'google_oauth2', uid:)
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
      'provider' => 'google_oauth2',
      'uid' => uid,
      'info' => { 'name' => user.name, 'email' => user.email, 'image' => user.image }
    )
    get '/auth/google_oauth2/callback'
    user
  end

  # System specs: go through the visible login UI.
  def sign_in_through_ui(admin: false, super_admin: false)
    mock_github_omniauth
    visit login_path
    within('#nav') { click_button I18n.t('login.github_login') }
    promote(github_user, admin:, super_admin:)
  end

  private

  def github_user
    User.find_by!(email: GITHUB_AUTH_HASH['info']['email'])
  end

  def promote(user, admin:, super_admin:)
    user.update!(admin:, super_admin:) if admin || super_admin
    user
  end
end

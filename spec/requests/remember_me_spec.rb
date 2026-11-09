require 'spec_helper'

describe 'Remember-me cookie', type: :request do
  let!(:user) { login_as(create(:user)) }

  def drop_session
    cookies.delete('_on_ruby_v2')
  end

  it 'signs the user in without a session' do
    drop_session

    get edit_user_path(user)

    expect(response).to have_http_status(:ok)
  end

  it 'does not sign in with a tampered cookie' do
    drop_session
    cookies['remember_me'] = "#{cookies['remember_me']}x"

    get edit_user_path(user)

    expect(response).to have_http_status(:redirect)
  end

  it 'does not sign in after sign out' do
    get destroy_session_path
    drop_session

    get edit_user_path(user)

    expect(response).to have_http_status(:redirect)
  end
end

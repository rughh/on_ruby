# frozen_string_literal: true

module UserHandling
  protected

  def authenticate_admin_user!
    redirect_to root_path, alert: t('flash.only_admins') unless signed_in? && current_user.admin?
  end

  def authenticate_super_admin_user!
    redirect_to root_path, alert: t('flash.only_admins') unless signed_in? && current_user.super_admin?
  end

  def authenticate!
    return if signed_in?

    redirect_to login_path, alert: t('flash.not_logged_in')
  end

  def authenticate_current_user!
    redirect_to root_path, alert: t('flash.not_authenticated') unless signed_in? && current_user?
  end

  def current_user?
    current_user == user
  end

  def current_user
    @current_user ||= find_by_session_or_cookies
  end

  def signed_in?
    !!current_user
  end

  def sign_in(user)
    @current_user = user
    session[:user_id] = user.id
    cookies.permanent.signed[:remember_me] = [user.id, user.salt]
    user_cookie(user)
  end

  def sign_out
    session.clear
    cookies.permanent.signed[:remember_me] = ['', '']
    clear_user_cookie
  end

  def user_cookie(user)
    data = {
      slug: user.to_param,
      name: user.name.to_s,
      image_path: helpers.cache_image_path(user),
      profile_path: user_path(user),
      edit_path: edit_user_path(user),
      logout_path: destroy_session_path,
      hide_jobs: user.hide_jobs?,
      missing_name: user.missing_name?,
      is_admin: (true if user.admin?),
      is_super_admin: (true if user.super_admin?),
    }.compact

    cookies.permanent['_on_ruby_user'] = {
      value: data.to_json,
      domain: request.domain,
      httponly: false,
      same_site: :lax,
    }
  end

  def clear_user_cookie
    cookies.delete('_on_ruby_user', domain: request.domain)
  end

  def find_by_session_or_cookies
    User.find_by(id: session[:user_id]) || User.authenticated_with_token(*remember_me)
  end

  def remember_me
    cookies.permanent.signed[:remember_me] || ['', '']
  rescue StandardError
    ['', '']
  end
end

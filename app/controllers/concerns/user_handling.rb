module UserHandling
  protected

  def authenticate_admin_user!
    unless signed_in? && current_user.admin?
      redirect_to root_path, alert: t('flash.only_admins')
    end
  end

  def authenticate!
    return if signed_in?

    redirect_to login_path, alert: t('flash.not_logged_in')
  end

  def authenticate_current_user!
    unless signed_in? && current_user?
      redirect_to root_path, alert: t('flash.not_authenticated')
    end
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
  end

  def sign_out
    session.clear
    cookies.permanent.signed[:remember_me] = ['', '']
  end

  def find_by_session_or_cookies
    User.find_by_id(session[:user_id]) || User.authenticated_with_token(*remember_me)
  end

  def remember_me
    cookies.permanent.signed[:remember_me] || ['', '']
  rescue
    ['', '']
  end
end

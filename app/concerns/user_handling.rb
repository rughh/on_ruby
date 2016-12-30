module UserHandling
  protected

  def authenticate_admin_user!
    unless signed_in? && current_user.admin?
      redirect_to root_path, alert: t('flash.only_admins')
    end
  end

  def authenticate!
    redirect_to root_path, alert: t('flash.not_authenticated') unless signed_in?
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
    @current_user ||= User.find_by_session_or_cookies(session, cookies)
  end

  def signed_in?
    !!current_user
  end

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.id
  end
end

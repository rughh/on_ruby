class SessionsController < ApplicationController
  def offline_login
    self.current_user = User.find_by_nickname(params[:nickname])
    redirect_to root_path, notice: 'Offline Login!'
  end

  def create
    begin
      authorization = Authorization.handle_authorization request.env['omniauth.auth']
      self.current_user = authorization.user
      options = { notice: t('flash.logged_in', name: current_user.name) }
      cookies.permanent.signed[:remember_me] = [current_user.id, current_user.salt]
    rescue User::DuplicateNickname => error
      options = { alert: t('flash.duplicate_nick', name: error.nickname) }
    end
    redirect_to request.env['omniauth.origin'] || root_path, options
  end

  def destroy
    session[:user_id] = nil
    cookies.permanent.signed[:remember_me] = ['', '']
    message = flash[:notice] || t('flash.logged_out')
    redirect_to root_path, notice: message
  end

  def failure
    redirect_to root_path, alert: t('flash.login_error')
  end

  def auth
    session[:omniauth_keys] = Usergroup.omniauth_keys(params[:provider], request)
    redirect_to "/auth/#{params[:provider]}"
  end
end
